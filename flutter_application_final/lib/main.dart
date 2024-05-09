import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/LoginScreen/login.dart';
import 'package:flutter_application_final/UI/MainScreen/main_screen.dart';


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
  checkUserLoggedIn();
}

Future<void> checkUserLoggedIn() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  if (user != null) {
    runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeArea(child: MainPage()),
    ));
  } else {
    runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SafeArea(child: LoginPage()),
    ));
  }
}