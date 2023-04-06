import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'OTP_verifcation_Page.dart';

class enterPhoneNumber extends StatefulWidget {
  const enterPhoneNumber({super.key});
  static String verify = '';

  @override
  State<enterPhoneNumber> createState() => _enterPhoneNumberState();
}

class _enterPhoneNumberState extends State<enterPhoneNumber> {
  late TextEditingController phoneController;
  final countryCodePicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  bool isButtonActive = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    phoneController.addListener(() {
      final isButtonActive = phoneController.text.trim().length == 10;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.black,
              Colors.white,
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              'Enter your phone number',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 150,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: countryCode != null ? countryCode!.flagImage : null,
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () async {
                    final code =
                        await countryCodePicker.showPicker(context: context);
                    setState(() {
                      countryCode = code;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white)),
                    child: Text(
                      countryCode?.dialCode ?? '+1',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLength: 10,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      labelText: 'Phone Number',
                      labelStyle:
                          const TextStyle(color: Colors.white, fontSize: 15),
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 219, 216, 216),
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 10, bottom: 30),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: ElevatedButton(
                    onPressed: isButtonActive
                        ? () async {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber:
                                  '${countryCode!.dialCode.toString() + phoneController.text}',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                setState(() {
                                  isLoading = false;
                                });
                                enterPhoneNumber.verify = verificationId;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => otpVerificationPage(),
                                  ),
                                );
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                            setState(() => isButtonActive = false);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 25,
                      minimumSize: Size(MediaQuery.of(context).size.width, 60),
                      backgroundColor: Colors.transparent.withOpacity(0.9),
                    ),
                    child:isLoading?const CircularProgressIndicator(color: Colors.white,strokeWidth: 3,): Text('Send OTP'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
