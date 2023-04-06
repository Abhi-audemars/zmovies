// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:zmovies/pages/choose_login.dart';
// import 'package:zmovies/services/auth_service.dart';

class menuScreen extends StatelessWidget {
  const menuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    GoogleSignIn _googleSignIn = GoogleSignIn();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 1, 8),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ChooseLogin.istrueornot
                  ? CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL!,
                      ),
                    )
                  : Lottie.network(
                      'https://assets6.lottiefiles.com/packages/lf20_TvLR5m.json',
                      height: 90,
                      width: 90,
                    ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ChooseLogin.istrueornot
                ? Text(FirebaseAuth.instance.currentUser!.displayName!,
                    style: GoogleFonts.poppins(
                        color: Colors.white70, fontSize: 18))
                : Text(
                    'Welcome',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                  ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: const [
              Icon(
                Icons.settings,
                color: Colors.white60,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Settings',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              Icon(
                Icons.subscriptions,
                color: Colors.white60,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Subscriptions',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              Icon(
                Icons.download,
                color: Colors.white60,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Downloads',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              Icon(
                Icons.favorite_sharp,
                color: Colors.white60,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Favorites',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _googleSignIn.disconnect();
              auth.signOut().then((value) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const ChooseLogin(),
                    ),
                    (route) => false);
              }).onError((error, stackTrace) {
                // error.toString();
                SnackBar(
                  content: Text(
                    error.toString(),
                  ),
                );
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(
                  Icons.logout_rounded,
                  color: Colors.white60,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
