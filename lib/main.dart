import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vendor_app_only/vendors/views/auth/vendor_auth_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid? await Firebase.initializeApp(options: FirebaseOptions(apiKey:  "AIzaSyD3EQXK37eQsxtWcXd3NB-WRnU12ur5h5I", appId: "1:830327029793:android:00a487e1f0e4853af7e360", messagingSenderId:  "830327029793", projectId: "my-store-79012",storageBucket: "gs://my-store-79012.appspot.com")):Firebase.initializeApp();
  
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:   VendorAuthView() ,
    );
  }
}

