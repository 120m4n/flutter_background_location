import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:flutter_background_location/widgets/btn_custom.dart';
// import 'package:flutter_background_location/widgets/columnas.dart';
import 'package:flutter_background_location/widgets/web_view_container.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_background_location/injection_container.dart';
import 'package:flutter_background_location/log_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await InjectionContainer().init();

  bg.DeviceInfo deviceInfo = await bg.DeviceInfo.getInstance();

  await bg.BackgroundGeolocation.ready(
    bg.Config(
        autoSyncThreshold: 7,
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_NAVIGATION,
        distanceFilter: 5.0,
        disableElasticity: false,
        stopOnTerminate: false,
        startOnBoot: true,
        preventSuspend: true,
        debug: true,
        // deferTime: ,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE,
        autoSync: true,
        // isMoving: true,
        url: "https://realtime.mapas-electrosoftware.xyz/api/locations",
        params: {
          'user_id': 'Gflutter/${deviceInfo.model}-${deviceInfo.version}',
        },
        backgroundPermissionRationale: bg.PermissionRationale(
            title:
                "Allow {applicationName} to access to this device's location in the background?",
            message:
                "In order to track your activity in the background, please enable {backgroundPermissionOptionLabel} location permission",
            positiveAction: "Change to {backgroundPermissionOptionLabel}",
            negativeAction: "Cancel"),
        notification: bg.Notification(title: "The Title", text: "The Text")),
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
      debugShowCheckedModeBanner: true,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.orangeAccent),
      ),
      routes: {
        // '/': (context) => const MyWidgetColumns(),
        '/': (context) => const MainPage(),
        '/webViewController': (context) => const WebViewContainer(),
        '/logPage': (context) => const LogPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView Flutter'),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Button('Activar GPS', () {
            Navigator.pushNamed(context, '/logPage');
          }),
          const SizedBox(
            height: 20,
            // width: 250,
          ),
          Button('Visor del Juego', () {
            Navigator.pushNamed(context, '/webViewController');
          })
        ],
      ),
    );
  }
}
