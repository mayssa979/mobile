import 'dart:async';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../database/database_service.dart';
import '../dtos/application_data.dart';
import '../main_app_ui/widgets/yes_no_dialog.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text pour indiquer de choisir une option
                Text(
                  'Choose your Favorite app ! ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Texte en gras
                    color: Colors.black, // Couleur du texte
                    fontStyle: FontStyle.italic, // Texte en italique
                    letterSpacing: 1.5, // Espacement des lettres
                  ),
                ),
                SizedBox(height: 20),
                // Premier bouton image
                ElevatedButton(
                  onPressed: () async {
                    await LaunchApp.openApp(
                      androidPackageName: 'com.facebook.katana',
                      openStore: true,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Couleur de fond du bouton
                    textStyle: TextStyle(
                      fontSize: 18,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Coins arrondis
                    ),
                  ),
                  child: Image.asset(
                    'images/fb.png',
                    height: 100,
                    width: 200,
                  ),
                ),
                SizedBox(height: 20),
                // Deuxième bouton image
                ElevatedButton(
                  onPressed: () async {
                    await LaunchApp.openApp(
                      androidPackageName: 'com.google.android.youtube',
                      openStore: true,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Couleur de fond du bouton
                    textStyle: TextStyle(
                      fontSize: 18,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Coins arrondis
                    ),
                  ),
                  child: Image.asset(
                    'images/y.png',
                    height: 100,
                    width: 200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
