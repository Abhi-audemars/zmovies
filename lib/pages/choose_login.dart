// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:zmovies/pages/email_login_signup.dart';
import 'package:zmovies/pages/enter_phone_number_screen.dart';
import 'package:zmovies/services/auth_service.dart';
import 'package:zmovies/utils/customButton.dart';
import 'package:zmovies/utils/drawer.dart';
// import 'package:zmovies/utils/drawer.dart';

class chooseLogin extends StatefulWidget {
  const chooseLogin({super.key});
  static bool istrueornot = false;

  @override
  State<chooseLogin> createState() => _chooseLoginState();
}

class _chooseLoginState extends State<chooseLogin> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      // width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey, Color.fromARGB(0, 0, 0, 0)],
        ),
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 350,
            ),
            DefaultTextStyle(
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              child: Text(
                'Please Log in to continue',
                style: GoogleFonts.poppins(),
              ),
            ),
            // Text(
            //   'Please Log in to continue',
            //   style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white),
            // ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                chooseLogin.istrueornot = false;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const enterPhoneNumber()));
              },
              child: customButton(
                color: const Color.fromARGB(33, 255, 255, 255),
                text: 'Continue with Phone number',
                lottie: Lottie.network(
                    'https://assets2.lottiefiles.com/packages/lf20_e16x4rwa.json'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                try {
                  chooseLogin.istrueornot = true;
                  AuthService().signInWithGoogle();
                  FirebaseAuth.instance.authStateChanges().listen((User? user) {
                    if (user == null) {
                      print('fuccck');
                    } else {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) =>const drawer()),
                          (route) => false);
                      print('signed in');
                    }
                  });
                } on FirebaseAuthException catch (e) {
                  e.toString();
                } catch (e) {
                  e.toString();
                }
              },
              child: customButton(
                color: const Color.fromARGB(115, 108, 78, 143),
                text: 'Continue with Google',
                lottie: Lottie.network(
                  'https://assets1.lottiefiles.com/private_files/lf30_3nvqj06a.json',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginSignupEmail()),
                    (route) => false);
              },
              child: customButton(
                color: const Color.fromARGB(92, 56, 115, 150),
                text: 'Continue with email',
                lottie: Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_ppjmx2th.json',
                    width: 30,
                    height: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
