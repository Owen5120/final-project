import 'package:flutter/material.dart';
import 'login.dart';
import 'package:geolocator/geolocator.dart';
class ChangeGeofence extends StatefulWidget {
  const ChangeGeofence({super.key});

  @override
  State<ChangeGeofence> createState() => _ChangeGeofenceState();
}
TextEditingController startlat  = TextEditingController();
TextEditingController startlong  = TextEditingController();
String startlatitude='';
String startlongitude ='';
Position? _currentLocation;
late bool servicePermission = false;
late LocationPermission permission;
var time;
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
class _ChangeGeofenceState extends State<ChangeGeofence> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Enter the new coordinates",style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.bold
              ),),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: TextFormField(
                  maxLength: 45,
                  controller: startlat,
                  style: TextStyle(height: 2.0),
                  decoration: InputDecoration(
                    hintText: 'Enter Latitude', // <-- Add the hint text here
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextFormField(
                  style: TextStyle(height: 2.0),
                  controller: startlong,
                  decoration: InputDecoration(
                    hintText: 'Enter Longitude', // <-- Add the hint text here
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        startlatitude=startlat.text;
                        startlongitude=startlong.text;
                        print(startlatitude);
                        print(startlongitude);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      });
                    },
                    child: Text("Ok!"),
                  )
              ),
              Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: ElevatedButton(
                    onPressed: () async{
                      _currentLocation = await _getCurrentLocation();
                      setState(() {
                        time=DateTime.now();
                      });
                    },
                    child: Text("Auto Class Location"),
                  )
              ),
              SizedBox(height: 10),
              Text("Current Location Coordinates", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              SizedBox(height: 6),
              Text("Latitude= ${_currentLocation?.latitude} , Longitude= ${_currentLocation?.longitude}"),
              Text("as of ${time}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 30),

            ],
          ),
        ),
      ),

    );
  }
}