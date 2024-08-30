import 'package:image_picker/image_picker.dart';

class VendorRegistrationController {
  // FUNCTION TO PICK STORE IMAGE

  pickStoreImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _image = await _picker.pickImage(source: source);

    if (_image != null) {
      return await _image.readAsBytes();
    } else {
      print("no image picked");
    }
  }

  // FUNCTION TO PICK STORE IMAGE ENDS
}
