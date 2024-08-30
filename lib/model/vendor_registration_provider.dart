import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app_only/controller/vendor_registration_controller.dart';

class VendorRegistrationProvider extends ChangeNotifier {
  final VendorRegistrationController _vendorRegistrationController =
      VendorRegistrationController();

  String? countryValue;
  String? stateValue;
  String? cityValue;
  Uint8List? _image;
  Uint8List? get image => _image;

  String? _taxStatus;
  String? get taxStatus => taxStatus;

  List<String> _taxOptions = ['YES', 'No'];
  List<String> get taxOptions => _taxOptions;

  void setCountryValue(String value) {
    countryValue = value;
    notifyListeners();
  }

  void setStateValue(String value) {
    stateValue = value;
    notifyListeners();
  }

  void setCityValue(String value) {
    cityValue = value;
    notifyListeners();
  }

  void selectImageFromGallery() async {
    final img =
        await _vendorRegistrationController.pickStoreImage(ImageSource.gallery);
    if (img != null) {
      _image = img;
      notifyListeners();
    }
  }

  void selectImageFromCamera() async {
    final img =
        await _vendorRegistrationController.pickStoreImage(ImageSource.camera);
    if (img != null) {
      _image = img;
      notifyListeners();
    }
  }

  void checkTaxStatus(String value) {
    if (_taxStatus != value) {
      _taxStatus = value;
      textFormField();
      notifyListeners();
    }
  }

  Widget textFormField() {
    if (_taxStatus == 'YES') {
      return TextFormField(
        decoration: InputDecoration(labelText: "Tax Number"),
      );
    }
    return SizedBox.shrink();
  }
}
