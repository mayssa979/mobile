import 'dart:ui';

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mini_projet_mobile/utils/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future signIn() async {
    try {
      // Attempt to sign in with FirebaseAuth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Get.to(() => const HomeScreen(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 400));
      // Sign-in successful, you can proceed with handling the correct data
    } catch (e) {
      CoolAlert.show(
        context: context,
        widget: WillPopScope(
          onWillPop: () async => false,
          child: Container(),
        ),
        type: CoolAlertType.error,
        loopAnimation: true,
        title: 'Email or password not valid!',
        confirmBtnColor: button,
        barrierDismissible: false,
        showCancelBtn: false,
        confirmBtnText: 'Try again',
        backgroundColor: button,
      );
    }
  }

  void openSignupScreen() {
    Get.to(() => const SignupScreen(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Parental login'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //image
              Image.asset(
                'images/login.jpg',
                height: 400,
                width:
                    double.infinity, // Set the width to fill the screen width
                fit: BoxFit.cover, // Make the image cover the width
              ),
              SizedBox(
                height: 20,
              ),
              //title
              Text('SIGN IN',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 18, fontWeight: FontWeight.bold)),

              //emailtextfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 242, 242),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //passwordtextfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 242, 242),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Password'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //signinbutton
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 12, 170, 162),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text('Sign in',
                            style: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ))),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //textsignup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not yet a member?',
                    style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: openSignupScreen,
                    child: Text(
                      ' Sign Up Now',
                      style: GoogleFonts.robotoCondensed(
                        color: Color.fromARGB(255, 236, 137, 43),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
