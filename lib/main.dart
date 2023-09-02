import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_background_location/injection_container.dart';
import 'package:flutter_background_location/log_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await InjectionContainer().init();

  await bg.BackgroundGeolocation.ready(
    bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 10.0,
      disableElasticity: true,
      stopOnTerminate: false,
      startOnBoot: true,
      preventSuspend: true,
      debug: true,
      // deferTime: ,
      logLevel: bg.Config.LOG_LEVEL_VERBOSE,
      autoSync: true,
      // isMoving: true,
      backgroundPermissionRationale: bg.PermissionRationale(
          title: "Allow {applicationName} to access to this device's location in the background?",
          message:
              "In order to track your activity in the background, please enable {backgroundPermissionOptionLabel} location permission",
          positiveAction: "Change to {backgroundPermissionOptionLabel}",
          negativeAction: "Cancel"),
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Background Geolocation',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.orangeAccent),
      ),
      home: const LogPage(),
    );
  }
}