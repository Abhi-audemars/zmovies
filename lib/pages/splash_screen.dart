import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zmovies/pages/choose_login.dart';
import 'package:zmovies/services/auth_service.dart';
import 'package:zmovies/utils/drawer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => drawer()), (route) => false);
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
