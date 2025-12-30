/// # Ingestion Provider
///
/// ## Description
/// 管理病历录入流程的状态。
///
/// ## Logic
/// - `pickImages`: 调用 GalleryService 选择图片。
/// - `submit`: 
///    1. 创建 Record 实体。
///    2. 并发处理所有图片 (Compress + Encrypt + Save)。
///    3. 保存 Record。
///    4. 触发 Timeline 刷新。

import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/image.dart';
import '../../data/models/record.dart';
import 'core_providers.dart';
import 'states/ingestion_state.dart';
import 'timeline_provider.dart';

part 'ingestion_provider.g.dart';

@riverpod
class IngestionController extends _$IngestionController {
  @override
  IngestionState build() {
    return const IngestionState();
  }

  void updateHospital(String name) {
    state = state.copyWith(hospitalName: name);
  }

  void updateDate(DateTime date) {
    state = state.copyWith(visitDate: date);
  }
  
  void updateNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  /// 选择相册图片
  Future<void> pickImages() async {
    try {
      final gallery = ref.read(galleryServiceProvider);
      final files = await gallery.pickImages();
      _addFiles(files);
    } catch (e) {
      _setError(e);
    }
  }

  /// 拍照
  Future<void> takePhoto() async {
    try {
      final picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        _addFiles([photo]);
      }
    } catch (e) {
      _setError(e);
    }
  }

  void _addFiles(List<XFile> files) {
    if (files.isNotEmpty) {
      state = state.copyWith(
        rawImages: [...state.rawImages, ...files],
        status: IngestionStatus.idle,
      );
    }
  }

  void _setError(Object e) {
    state = state.copyWith(
      status: IngestionStatus.error,
      errorMessage: e.toString(),
    );
  }

  /// 移除选中的图片
  void removeImage(int index) {
    final newList = [...state.rawImages];
    newList.removeAt(index);
    state = state.copyWith(rawImages: newList);
  }

  /// 切换标签选中状态
  void toggleTag(String tagId) {
    final current = [...state.selectedTagIds];
    if (current.contains(tagId)) {
      current.remove(tagId);
    } else {
      current.add(tagId);
    }
    state = state.copyWith(selectedTagIds: current);
  }

  /// 标签排序
  void reorderTags(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final current = [...state.selectedTagIds];
    final item = current.removeAt(oldIndex);
    current.insert(newIndex, item);
    state = state.copyWith(selectedTagIds: current);
  }

  /// 提交保存
  Future<void> submit() async {
    if (state.rawImages.isEmpty) {
      state = state.copyWith(status: IngestionStatus.error, errorMessage: "需至少包含一张图片");
      return;
    }

    state = state.copyWith(status: IngestionStatus.processing);

    try {
      final recordId = const Uuid().v4();
      final recordRepo = ref.read(recordRepositoryProvider);
      final imageRepo = ref.read(imageRepositoryProvider);
      final fileSecurity = ref.read(fileSecurityHelperProvider);
      final cryptoService = ref.read(cryptoServiceProvider);
      final imageProcessing = ref.read(imageProcessingServiceProvider);
      final pathService = ref.read(pathProviderServiceProvider); // Move up
      
      const currentPersonId = 'def_me'; // Phase 1 Single User
      
      final List<MedicalImage> medicalImages = [];
      
      // Process images concurrently
      await Future.wait(state.rawImages.asMap().entries.map((entry) async {
        final index = entry.key;
        final xFile = entry.value;
        final rawBytes = await xFile.readAsBytes();
        
        // 1. Image Processing
        final compressedBytes = await imageProcessing.compressImage(data: rawBytes);
        final thumbnailBytes = await imageProcessing.generateThumbnail(data: rawBytes);
        final dimensions = await imageProcessing.getDimensions(compressedBytes);

        // 2. Encrypt & Save Main File (Generate New Key)
        final fileResult = await fileSecurity.saveEncryptedFile(
          data: compressedBytes, 
          targetDir: pathService.imagesDirPath, // Absolute path
        );
        
        // 3. Encrypt & Save Thumbnail (REUSE Key)
        final keyBytes = base64Decode(fileResult.base64Key);
        final encryptedThumb = await cryptoService.encrypt(data: thumbnailBytes, key: keyBytes);
        
        final thumbFileName = '${const Uuid().v4()}.enc';
        final thumbRelPath = 'images/thumbnails/$thumbFileName';
        final thumbFile = await pathService.getSecureFile(thumbRelPath);
        if (!await thumbFile.parent.exists()) {
             await thumbFile.parent.create(recursive: true);
        }
        await thumbFile.writeAsBytes(encryptedThumb);

        // 4. Create Entity
        medicalImages.add(MedicalImage(
          id: const Uuid().v4(),
          recordId: recordId,
          encryptionKey: fileResult.base64Key,
          filePath: 'images/${fileResult.relativePath}', // Fix path to be relative from sandbox root?
          // Note: FileSecurityHelper returns relativePath as just the filename.
          // DB schema expects relative path from sandbox root?
          // T12/ImageRepo uses standard join logic?
          // Let's look at `Image.filePath` definition: "Encrypted file relative path".
          // If we store 'images/filename.enc', that's good.
          thumbnailPath: thumbRelPath,
          mimeType: 'image/png', // T10 fallback
          fileSize: compressedBytes.lengthInBytes,
          displayOrder: index,
          width: dimensions.width,
          height: dimensions.height,
          createdAt: DateTime.now(),
          tagIds: state.selectedTagIds, // Apply global tags to all images for Phase 1
        ));
      }));

      // 5. Create Record
      final record = MedicalRecord(
        id: recordId,
        personId: currentPersonId,
        hospitalName: state.hospitalName,
        notes: state.notes,
        notedAt: state.visitDate ?? DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: RecordStatus.archived,
        // images: medicalImages, // Not persisted here
      );
      
      // 6. Transactional Save
      await recordRepo.saveRecord(record);
      await imageRepo.saveImages(medicalImages);
      
      // 7. Refresh Timeline & Reset State
      ref.invalidate(timelineControllerProvider);
      state = const IngestionState(status: IngestionStatus.success);
      
    } catch (e) {
      state = state.copyWith(status: IngestionStatus.error, errorMessage: e.toString());
    }
  }
}
