import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainVendorView extends StatelessWidget {
  const MainVendorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Text("Approved")),
      ),
    );
  }
}
