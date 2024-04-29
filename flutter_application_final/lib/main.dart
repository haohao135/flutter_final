import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/LoginScreen/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: 'AIzaSyD0Jvvmj2t9h81NSLYaSrnrWpMvFt45Bac',
    appId: '1:431266103625:android:2198619b7799ddebb59a98',
    messagingSenderId: '431266103625',
    projectId: 'flutter-ck-933e2',
    storageBucket: 'flutter-ck-933e2.appspot.com',
  )
);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeArea(child: LoginPage()),
  ));
}
