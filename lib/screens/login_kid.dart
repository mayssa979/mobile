import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mini_projet_mobile/utils/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import '../variables.dart';
import '../database/database_service.dart';
import 'menukids.dart';

class LoginKid extends StatefulWidget {
  const LoginKid({super.key});

  @override
  State<LoginKid> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginKid> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  String? name;

  Future signIn() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('children')
              .where('enfant', isEqualTo: name)
              .get();
      if (querySnapshot.docs.isNotEmpty) {
        childData = querySnapshot.docs.first.get('temps');
        print('Child Data: $childData');
        Get.to(() => MenuScreen(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 400));
        print('This user already exists!');
      } else {
        CoolAlert.show(
          context: context,
          widget: WillPopScope(
            onWillPop: () async => false,
            child: Container(),
          ),
          type: CoolAlertType.error,
          loopAnimation: true,
          title: 'This kid does not exist!',
          confirmBtnColor: button,
          barrierDismissible: false,
          showCancelBtn: false,
          confirmBtnText: 'Try again',
          backgroundColor: button,
        );
        print('This user does not exist!.');
      }
    } catch (e) {
      print('error!');
    }
  }

  void openSignupScreen() {
    Navigator.of(context).pushReplacementNamed('signupScreen');
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
        title: Text('Kids log in'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //image
              Image.asset(
                'images/login-kid.jpg',
                height: 400,
                width:
                    double.infinity, // Set the width to fill the screen width
                fit: BoxFit.cover,
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
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              //signinbutton

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: signinkid,
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
            ]),
          ),
        ),
      ),
    );
  }
}
