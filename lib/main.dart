import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:zmovies/pages/OTP_verifcation_Page.dart';
// import 'package:zmovies/pages/choose_login.dart';
// import 'package:zmovies/pages/email_login_signup.dart';
// import 'package:zmovies/pages/enter_phone_number_screen.dart';
// import 'package:zmovies/pages/homepage.dart';
import 'package:zmovies/services/auth_service.dart';
// import 'package:zmovies/utils/drawer.dart';
// import 'package:zmovies/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.purple),
        home:  AuthService().handelAuthState(),
        );
  }
}
