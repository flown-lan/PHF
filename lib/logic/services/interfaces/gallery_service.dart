/// # IGalleryService
/// 
/// 相册选择服务接口。
import 'package:image_picker/image_picker.dart';

abstract class IGalleryService {
  /// 打开系统相册选择多张图片
  Future<List<XFile>> pickImages();
}
