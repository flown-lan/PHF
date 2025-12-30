
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../logic/providers/ingestion_provider.dart';
import '../../../logic/providers/states/ingestion_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/active_button.dart';

class IngestionPage extends ConsumerStatefulWidget {
  const IngestionPage({super.key});

  @override
  ConsumerState<IngestionPage> createState() => _IngestionPageState();
}

class _IngestionPageState extends ConsumerState<IngestionPage> {
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _hospitalController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ingestionControllerProvider);
    final notifier = ref.read(ingestionControllerProvider.notifier);

    // Sync controllers if needed (though usually we want one-way or careful two-way)
    // For simplicity, we just use them to update the state on change.

    // Handle Success/Error Navigation/Dialogs
    ref.listen(ingestionControllerProvider.select((s) => s.status), (previous, next) {
      if (next == IngestionStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('保存成功')),
        );
        Navigator.of(context).pop();
      } else if (next == IngestionStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('提交失败: ${state.errorMessage}')),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.bgWhite,
      appBar: AppBar(
        title: const Text('录入病历'),
        backgroundColor: AppTheme.bgWhite,
        foregroundColor: AppTheme.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hospital Name
            TextField(
              controller: _hospitalController,
              decoration: const InputDecoration(
                labelText: '医院名称',
                hintText: '例如：上海瑞金医院',
                prefixIcon: Icon(Icons.apartment),
              ),
              onChanged: (val) => notifier.updateHospital(val),
            ),
            const SizedBox(height: 16),

            // 2. Visit Date
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today, color: AppTheme.primaryTeal),
              title: const Text('就诊日期'),
              subtitle: Text(
                state.visitDate != null 
                  ? DateFormat('yyyy-MM-dd').format(state.visitDate!) 
                  : '未选择',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: state.visitDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  notifier.updateDate(date);
                }
              },
            ),
            const Divider(),
            const SizedBox(height: 16),

            // 3. Image Grid
            const Text(
              '病历资料 (照片)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.rawImages.length + 1,
              itemBuilder: (context, index) {
                if (index == state.rawImages.length) {
                  // Add Button
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (context) => SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('拍照'),
                                onTap: () {
                                  Navigator.pop(context);
                                  notifier.takePhoto();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('从相册选择'),
                                onTap: () {
                                  Navigator.pop(context);
                                  notifier.pickImages();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.bgGray,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.textHint.withValues(alpha: 0.3)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, color: AppTheme.textHint),
                          SizedBox(height: 4),
                          Text('添加图片', style: TextStyle(fontSize: 10, color: AppTheme.textHint)),
                        ],
                      ),
                    ),
                  );
                }

                final image = state.rawImages[index];
                return Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(image.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => notifier.removeImage(index),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // 4. Notes
            TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: '备注',
                hintText: '输入其他关键信息...',
                alignLabelWithHint: true,
              ),
              onChanged: (val) => notifier.updateNotes(val),
            ),

            const SizedBox(height: 40),

            // 5. Submit Button
            SizedBox(
              width: double.infinity,
              child: ActiveButton(
                text: '加密保存',
                onPressed: (state.rawImages.isEmpty) ? null : () => notifier.submit(),
                isLoading: state.status == IngestionStatus.processing || state.status == IngestionStatus.saving,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
