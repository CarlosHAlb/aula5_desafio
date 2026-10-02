import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker picker = ImagePicker();

  Future<XFile?> tirarFoto() async {
    return await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
  }
}
