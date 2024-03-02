import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'HomeScreenRecognize.dart';
import 'changeGeofence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeolocationApp extends StatefulWidget {

  const GeolocationApp({
    Key? key,
  }) : super(key: key);

  @override
  State<GeolocationApp> createState() => _GeolocationAppState();
}

class _GeolocationAppState extends State<GeolocationApp> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  var time;

  double startLatitude = double.parse(startlatitude); // Initialize with default value
  double startLongitude = double.parse(startlongitude); // Initialize with default value
  double? distanceInMeter = 0.0;

  @override
  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service Disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Location'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Location Coordinates", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              SizedBox(height: 6),
              Text("Latitude= ${_currentLocation?.latitude} , Longitude= ${_currentLocation?.longitude}"),
              Text("as of ${time}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  _currentLocation = await _getCurrentLocation();
                  distanceInMeter = await Geolocator.distanceBetween(
                    startLatitude,
                    startLongitude,
                    _currentLocation!.latitude,
                    _currentLocation!.longitude,
                  );
                  print(distanceInMeter);
                  if (distanceInMeter! <= 100) {
                    print("You are inside the radius");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreenRecognize()),
                    );
                  } else {
                    print("You are outside the prescribed radius");
                  }
                  setState(() {
                    time = DateTime.now();
                  });
                  print("${_currentLocation}");
                },
                child: Text("Get Current Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
