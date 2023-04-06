// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zmovies/pages/splash_screen.dart';
import 'package:zmovies/pages/splashscreen2.dart';

class AuthService {
  handelAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const SplashScreen();
          } else {
            return const splashscreen2();
          }
        });
  }

  saveuser(String email, String name, String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'email': email, 'name': name});
  }

  signUpUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await saveuser(email, name, userCredential.user!.uid);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Registration Successful')));
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Weak Password')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Email already exists')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  signInUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('You are now logged in ')));
    } on FirebaseException catch (e) {
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context)
          .showSnackBar( const SnackBar(content: Text('User does not exists')));
      }
      else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Incorrect Password')));
      }
    }
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>["email"],
    ).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
