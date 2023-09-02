import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_background_location/injection_container.dart';
import 'package:flutter_background_location/widgets/log_page/log_item.dart';

class LogPage extends StatefulWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  bool _isBgStarted = false;
  List<String> savedLocations = sl<Box<String>>().values.toList();

  @override
  void initState() {
    super.initState();
    bg.BackgroundGeolocation.state.then((locationTrackerState) => setState(
          () => _isBgStarted = locationTrackerState.enabled,
        ));
    bg.BackgroundGeolocation.onLocation(
      onLocationChanged, (bg.LocationError error) {
        // Handle LocationError here.
        print("[onLocation] ERROR: $error");  
    });

    bg.BackgroundGeolocation.onHttp((bg.HttpEvent response) {
      print('[http] success? ${response.success}, status? ${response.status}');
    });

    // bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
    //   print("[onMotionChange] isMoving? ${location.isMoving}");
    // });
  }

  // @override
  // void dispose() {
  //   bg.BackgroundGeolocation.changePace(false);
  //   bg.BackgroundGeolocation.stop();
  //   super.dispose();
  // }

  void onLocationChanged(bg.Location newLocation) {
    setState(() {
      final label = getLocationLabel(newLocation);
      savedLocations.add(label);
      sl<Box<String>>().add(label);
    });
  }

  String getLocationLabel(bg.Location location) =>
      'lat-${location.coords.latitude}  lon-${location.coords.longitude}  time-${location.timestamp}  isMoving-${location.isMoving}';

  void onChangeLocationTracker(bool value) {
    setState(() => _isBgStarted = value);
    if (_isBgStarted) {
      bg.BackgroundGeolocation.start();
      bg.BackgroundGeolocation.changePace(true);
    } else {
      bg.BackgroundGeolocation.changePace(false);
      bg.BackgroundGeolocation.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geolocation Logs"),
        actions: [
          Switch(
            value: _isBgStarted,
            onChanged: onChangeLocationTracker,
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (savedLocations.isEmpty) {
          return const Center(
              child: Text(
            'Empty Saved Locations',
            style: TextStyle(fontSize: 20),
          ));
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: savedLocations.length,
          itemBuilder: (context, index) => LogItem(
            index: index,
            locationLabel: savedLocations[index],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        );
      }),
    );
  }
}
