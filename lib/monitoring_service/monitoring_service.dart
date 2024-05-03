import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '/alert_dialog_service/alert_dialog_service.dart';
import '/database/database_service.dart';
import '/dtos/application_data.dart';
import '/monitoring_service/utils/user_usage_utils.dart';
import 'package:usage_stats/usage_stats.dart';
import '../variables.dart';

const String STOP_MONITORING_SERVICE_KEY = "stop";
const String SET_APPS_NAME_FOR_MONITORING_KEY = "setAppsNames";
const String APP_NAMES_LIST_KEY = "appNames";
var timeleft = 0;
// Entry Point for Monitoring Isolate
@pragma('vm:entry-point')
onMonitoringServiceStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService databaseService = await DatabaseService.instance();

  Map<String, ApplicationData> monitoredApplicationSet = {};

  // Stop this background service
  _registerListener(service);

  Map<String, UsageInfo> previousUsageSession =
      await getCurrentUsageStats(monitoredApplicationSet);
  _startTimer(databaseService, monitoredApplicationSet, previousUsageSession);
}

Future<void> _startTimer(
    DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet,
    Map<String, UsageInfo> previousUsageSession) async {
  //print('time :$childData');
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    /* while (timeleft < 30) {
      timeleft++;
    }*/
    timer.cancel();
    _setMonitoringApplicationsSet(databaseService, monitoredApplicationSet);
    Map<String, UsageInfo> currentUsageSession =
        await getCurrentUsageStats(monitoredApplicationSet);
    String? appOpened = checkIfAnyAppHasBeenOpened(
        currentUsageSession, previousUsageSession, monitoredApplicationSet);
    if (appOpened != null) {
      AlertDialogService.createAlertDialog();
    }
    previousUsageSession = currentUsageSession;

    _startTimer(databaseService, monitoredApplicationSet, previousUsageSession);
  });
}

_setMonitoringApplicationsSet(DatabaseService databaseService,
    Map<String, ApplicationData> monitoredApplicationSet) {
  List<ApplicationData> monitoredApps = databaseService.getAllAppData();
  monitoredApplicationSet.clear();

  for (ApplicationData app in monitoredApps) {
    monitoredApplicationSet[app.appId] = app;
  }
}

_registerListener(ServiceInstance service) {
  service.on(STOP_MONITORING_SERVICE_KEY).listen((event) {
    service.stopSelf();
  });
}
