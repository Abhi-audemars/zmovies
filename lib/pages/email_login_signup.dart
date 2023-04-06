// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zmovies/services/auth_service.dart';
import 'package:zmovies/utils/drawer.dart';

class LoginSignupEmail extends StatefulWidget {
  const LoginSignupEmail({super.key});

  @override
  State<LoginSignupEmail> createState() => _LoginSignupEmailState();
}

class _LoginSignupEmailState extends State<LoginSignupEmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController username = TextEditingController();
  bool isSignUpScreen = true;
  bool isRememberMe = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    username.dispose();
    super.dispose();
  }

  authSignUpMethod() {
    try {
      AuthService().signUpUser(emailController.text, passwordController.text,
          username.text, context);
      FirebaseAuth.instance.authStateChanges().listen(
        (User? user) {
          if (user == null) {
            return;
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const drawer(),
                ),
                (route) => false);
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  authSignInMethod() {
    try {
      AuthService()
          .signInUser(emailController.text, passwordController.text, context);
      FirebaseAuth.instance.authStateChanges().listen(
        (User? user) {
          if (user == null) {
            return;
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const drawer(),
                ),
                (route) => false);
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(91, 45, 44, 44),
      body: Stack(
        children: [
          submitButton2(true),
          Positioned(
            top: isSignUpScreen ? 200 : 230,
            child: AnimatedContainer(
              duration: const Duration(microseconds: 900),
              curve: Curves.bounceOut,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: isSignUpScreen ? 300 : 255,
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  // border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                        color:
                            const Color.fromARGB(255, 222, 220, 220).withOpacity(0.3),
                        blurRadius: 9,
                        spreadRadius: 4),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUpScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'LOGIN',
                                style: GoogleFonts.poppins(
                                    color: !isSignUpScreen
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: isSignUpScreen
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                              ),
                              if (!isSignUpScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignUpScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'SIGNUP',
                                style: GoogleFonts.poppins(
                                    color: isSignUpScreen
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: isSignUpScreen
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              if (isSignUpScreen)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignUpScreen) buildSugnUpSection(),
                    if (!isSignUpScreen) buildSignInSection(),
                  ],
                ),
              ),
            ),
          ),
          submitButton2(false)
        ],
      ),
    );
  }

  Positioned submitButton2(bool shadows) {
    return Positioned(
      top: isSignUpScreen ? 454 : 440,
      right: 0,
      left: 0,
      child: Center(
        child: InkWell(
          onTap: () {
            isSignUpScreen ? authSignUpMethod() : authSignInMethod();
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  if (shadows)
                    BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        offset: const Offset(0, 1),
                        spreadRadius: 1.5,
                        blurRadius: 8)
                ]),
            child: !shadows
                ? Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 252, 199, 120),
                              Color.fromARGB(255, 248, 84, 73)
                            ]),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              offset: const Offset(0, 1))
                        ]),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                : const Center(),
          ),
        ),
      ),
    );
  }

  Container buildSignInSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          BuildTextField(Icons.mail_outline, 'abc@gmail.com', false, true,
              emailController),
          BuildTextField(
              Icons.lock_outline, 'password', true, false, passwordController),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    focusColor: Colors.red,
                    side: const BorderSide(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  const Text(
                    'Remember me',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildSugnUpSection() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          BuildTextField(Icons.person, 'User Name', false, false, username),
          BuildTextField(
              Icons.email_outlined, 'Email', false, true, emailController),
          BuildTextField(
              Icons.lock_outline, 'Password', true, false, passwordController),
        ],
      ),
    );
  }

  Widget BuildTextField(IconData icon, String hinttext, bool isPassword,
      bool isEmail, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(35),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(35),
          ),
          contentPadding: const EdgeInsets.all(10),
          hintText: hinttext,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}
