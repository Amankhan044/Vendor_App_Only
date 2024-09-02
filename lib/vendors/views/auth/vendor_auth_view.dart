import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app_only/vendors/views/auth/vendor_registration_view.dart';
import 'package:vendor_app_only/vendors/views/screens/landing_view.dart';

class VendorAuthView extends StatelessWidget {
  const VendorAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
          );
        }
        return LandingView();
      },
    );
  }
}
