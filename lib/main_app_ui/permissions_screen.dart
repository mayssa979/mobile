import 'dart:async';

import 'package:flutter_mini_projet_mobile/utils/colors.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:google_fonts/google_fonts.dart';
import '/database/database_service.dart';
import '/main_app_ui/home.dart';
import '/main_app_ui/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:usage_stats/usage_stats.dart';

class PermissionsScreen extends StatefulWidget {
  DatabaseService dbService;
  PermissionsScreen(this.dbService);

  @override
  State<StatefulWidget> createState() {
    return _PermissionsScreenState();
  }
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool usagePermissionGranted = false;
  bool drawOverOtherAppsPermissionGranted = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      usagePermissionGranted = (await UsageStats.checkUsagePermission())!;
      drawOverOtherAppsPermissionGranted =
          await FlutterOverlayWindow.isPermissionGranted();
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Text(
          "Permissions Required",
          style: TextStyle(
            fontSize: screenWidth * 0.06,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        _aboutPermissionsSection(),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _usagePermissionWidget(),
            SizedBox(
              width: screenWidth * 0.07,
            ),
            _overlayWidgetPermissionWidget(),
          ],
        ),
        const Spacer(),
        drawOverOtherAppsPermissionGranted && usagePermissionGranted
            ? _continueToAppButton()
            : const SizedBox.shrink(),
        SizedBox(
          height: screenHeight * 0.02,
        )
      ],
    ));
  }

  Widget _aboutPermissionsSection() {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        height: screenHeight * 0.33,
        width: screenWidth * 0.95,
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.1,
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: screenWidth * 0.09,
                        child: Icon(
                          Icons.query_stats,
                          size: screenWidth * 0.13,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: screenWidth * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Usage Stats",
                          style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "To determine Application startup",
                          style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.1,
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: screenWidth * 0.09,
                        child: Icon(
                          Icons.timer,
                          size: screenWidth * 0.13,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: screenWidth * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Display Over Apps",
                          style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "To popup a timer display",
                          style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _continueToAppButton() {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: (drawOverOtherAppsPermissionGranted && usagePermissionGranted)
            ? () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Home(widget.dbService)))
            : null,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: button, borderRadius: BorderRadius.circular(12)),
          child: Center(
              child: Text('Continue',
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ))),
        ),
      ),
    );
  }

  Widget _usagePermissionWidget() {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.2,
      width: screenWidth * 0.35,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        //color: Colors.blue,
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.query_stats,
                  size: screenWidth * 0.1,
                  color: Colors.blue,
                ),
                Text(
                  " : ",
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
                Icon(
                  usagePermissionGranted
                      ? Icons.check_circle_sharp
                      : Icons.close_rounded,
                  color: usagePermissionGranted ? Colors.green : Colors.red,
                  size: screenWidth * 0.1,
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              disabledColor: Colors.grey,
              onPressed: usagePermissionGranted
                  ? null
                  : () async {
                      await _askForUsagePermission();
                      setState(() {});
                    },
              child: Text(
                "Grant",
                style: TextStyle(
                    fontSize: screenWidth * 0.03, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _overlayWidgetPermissionWidget() {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.2,
      width: screenWidth * 0.35,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.timer,
                  size: screenWidth * 0.1,
                  color: Colors.blue,
                ),
                Text(
                  " : ",
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
                Icon(
                  drawOverOtherAppsPermissionGranted
                      ? Icons.check_circle_sharp
                      : Icons.close_rounded,
                  color: drawOverOtherAppsPermissionGranted
                      ? Colors.green
                      : Colors.red,
                  size: screenWidth * 0.1,
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              disabledColor: Colors.grey,
              onPressed: drawOverOtherAppsPermissionGranted
                  ? null
                  : () async {
                      await _askForDisplayOverWidgetsPermission();
                      setState(() {});
                    },
              child: Text(
                "Grant",
                style: TextStyle(
                    fontSize: screenWidth * 0.03, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  _askForUsagePermission() async {
    UsageStats.grantUsagePermission();
  }

  _askForDisplayOverWidgetsPermission() async {
    bool? overlayPermissionsGranted =
        await FlutterOverlayWindow.requestPermission();
    if (overlayPermissionsGranted != null && !overlayPermissionsGranted) {
      debugPrint("Overlay Permissions not granted!");
    }
  }
}
