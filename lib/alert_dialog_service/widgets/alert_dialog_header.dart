import 'package:external_app_launcher/external_app_launcher.dart';
import '/alert_dialog_service/alert_dialog_service.dart';
import '/main_app_ui/utils/fonts.dart';
import 'package:flutter/material.dart';

class AlertDialogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: screenHeight * 0.4,
        child: Column(
          children: [
            /* Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: Image(
                  image: const AssetImage("assets/icons/ia_logo.png"),
                  width: screenHeight * 0.15,
                )),*/
            Spacer(),
            _title(),
            Spacer(),
            _dismissButton(context),
            SizedBox(width: screenWidth * 0.025)
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text("out of time!!!!",
        style: Fonts.header3(color: Color.fromARGB(0, 255, 255, 255)));
  }

  Widget _dismissButton(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return IconButton(
      color: Color.fromARGB(255, 21, 5, 243),
      onPressed: () async {
        await LaunchApp.openApp(
          androidPackageName: 'com.example.flutter_mini_projet_mobile',
          openStore: true,
        );
        await AlertDialogService.closeAlertDialog();
      },
      icon: Icon(
        Icons.close,
        size: screenHeight * 0.04,
      ),
    );
  }
}
