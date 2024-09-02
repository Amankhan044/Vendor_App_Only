import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_app_only/controller/vendor_registration_controller.dart';

class VendorRegistrationProvider extends ChangeNotifier {
  final VendorRegistrationController _vendorRegistrationController =
      VendorRegistrationController();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  late String businessName;
  late String emailAddress;
  late String PhoneNumber;
  late String taxNumber;
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
        onChanged: (value) {
          taxNumber = value;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your tax number';
          }
          return null;
        },
        decoration: InputDecoration(labelText: "Tax Number"),
      );
    }
    return SizedBox.shrink();
  }

  Future<String?> _uploadVendorProfileToFirebase(Uint8List? imageData) async {
    try {
      Reference storageRef =
          _storage.ref().child('storeimage').child(_auth.currentUser!.uid);

      UploadTask uploadTask = storageRef.putData(imageData!);

      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<String> saveVendorInfo(
    String businessName,
    String emailAddress,
    String PhoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    String taxStatus,
    String taxNumber,
    Uint8List? image,
  ) async {
    String res = 'some error occured';

    try {
   
        String? storeImage = await _uploadVendorProfileToFirebase(image);

        await _firestore.collection('vendors').doc(_auth.currentUser!.uid).set({
          'bussinessName': businessName,
          'emailAddress': emailAddress,
          'phoneNumber': PhoneNumber,
          'countryValue': countryValue,
          'stateValue': stateValue,
          'cityValue': cityValue,
          'taxStatus': taxStatus,
          'taxNumber': taxNumber,
          'storeImage': storeImage,
          'approved': false
        });

    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  void saveVendorDetails() async {
    EasyLoading.show( status: 'PLEASE WAIT');
    if (_formKey.currentState!.validate()) {
      await saveVendorInfo(
          businessName,
          emailAddress,
          PhoneNumber,
          countryValue!,
          stateValue!,
          cityValue!,
          _taxStatus!,
          taxNumber,
          _image).whenComplete((){
            EasyLoading.dismiss();
             _formKey.currentState!.reset();
      _image=null;
      notifyListeners();
          });
    } else {
      print("bad");
      EasyLoading.dismiss();
     
    }
  }
}
