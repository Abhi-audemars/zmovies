import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
// import 'package:zmovies/pages/choose_login.dart';
import 'package:zmovies/pages/enter_phone_number_screen.dart';
import 'package:zmovies/utils/drawer.dart';

class otpVerificationPage extends StatefulWidget {
  const otpVerificationPage({super.key});

  @override
  State<otpVerificationPage> createState() => _otpVerificationPageState();
}

class _otpVerificationPageState extends State<otpVerificationPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  bool isLoading = false;
  var code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Text(
              'SMS verification',
              style: GoogleFonts.poppins(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Enter the 6 digit code sent to your number',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Pinput(
                onChanged: (value) {
                  code = value;
                },
                length: 6,
                defaultPinTheme: PinTheme(
                  textStyle: const TextStyle(fontSize: 25, color: Colors.white),
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                    color: Color.fromARGB(250, 148, 146, 146),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  setState(() {
                    isLoading = true;
                  });
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: enterPhoneNumber.verify, smsCode: code);
                  await auth.signInWithCredential(credential);
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => drawer()),
                      (route) => false);
                } catch (e) {
                  print('wrong otp');
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 24,
                  minimumSize: Size(MediaQuery.of(context).size.width, 45),
                  backgroundColor: Colors.black),
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : Text(
                      'Verify',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
