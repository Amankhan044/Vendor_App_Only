import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app_only/model/vendors_user_models.dart';
import 'package:vendor_app_only/vendors/views/auth/vendor_registration_view.dart';
import 'package:vendor_app_only/vendors/views/screens/main_vendor_view.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference _vendorsStream =
        FirebaseFirestore.instance.collection('vendors');
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        stream: _vendorsStream.doc(_auth.currentUser?.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(
                child: Text("Document does not exist or data is null"));
          }
          if (!snapshot.data!.exists) {
            return VendorRegistrationView();
          }
          VendorsUserModel vendorsUserModel = VendorsUserModel.fromJson(
              snapshot.data!.data()! as Map<String, dynamic>);

          if (vendorsUserModel.approved==true) {
            return MainVendorView();
          } else {
             return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    vendorsUserModel.storeImage.toString(),
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  vendorsUserModel.bussinessName.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Your application has been sent to shop admin\nAdmin will get back to you soon",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    child: Text('SignOut'))
              ],
            ),
          );
            
          }



         
        },
      ),
    );
  }
}
