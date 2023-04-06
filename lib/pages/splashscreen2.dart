// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zmovies/pages/choose_login.dart';

class splashscreen2 extends StatefulWidget {
  const splashscreen2({super.key});

  @override
  State<splashscreen2> createState() => _splashscreen2State();
}

class _splashscreen2State extends State<splashscreen2> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const ChooseLogin()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Z',
                style: TextStyle(
                    fontSize: 85,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Lottie.network(
                  'https://assets4.lottiefiles.com/packages/lf20_itjl9rou.json',
                  height: 60,
                  fit: BoxFit.contain)
            ],
          ),
        ),
      ),
    );
  }
}
