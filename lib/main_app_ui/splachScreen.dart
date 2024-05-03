import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';
import '../database/database_service.dart';
import '../monitoring_service/utils/flutter_background_service_utils.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 5),
      () => Get.off(() => Auth(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 400)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RollingImages(), // Custom widget for rolling image circles
            ],
          ),
        ),
      ),
    );
  }
}

class RollingImages extends StatefulWidget {
  @override
  _RollingImagesState createState() => _RollingImagesState();
}

class _RollingImagesState extends State<RollingImages>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Duration for the animation
    );

    _animation1 = Tween<double>(
      begin: 0.0,
      end: 100.0, // Adjust the vertical translation distance for circle 1
    ).animate(_controller);

    _animation2 = Tween<double>(
      begin: 0.0,
      end: 100.0, // Adjust the vertical translation distance for circle 2
    ).animate(_controller);

    _animation3 = Tween<double>(
      begin: 0.0,
      end: 100.0, // Adjust the vertical translation distance for circle 3
    ).animate(_controller);

    _controller.repeat(reverse: true); // Repeat the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation1,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation1.value),
              child: RollImage(imagePath: "images/circle.png"),
            );
          },
        ),
        SizedBox(width: 10),
        AnimatedBuilder(
          animation: _animation2,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation2.value),
              child: RollImage(imagePath: "images/circle.png"),
            );
          },
        ),
        SizedBox(width: 10),
        AnimatedBuilder(
          animation: _animation3,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation3.value),
              child: RollImage(imagePath: "images/circle.png"),
            );
          },
        ),
      ],
    );
  }
}

class RollImage extends StatelessWidget {
  final String imagePath;

  RollImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 25, // Adjust width and height as needed
      height: 25,
    );
  }
}
