import 'package:flutter/material.dart';
import 'ViewStudentsAttendance.dart';
import 'geofencing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'changeGeofence.dart';
import 'package:get/get.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({Key? key}) : super(key: key);

  @override
  State<StaffHomePage> createState() => _HomePageState();
}
class _HomePageState extends State<StaffHomePage> {

  final List locale =[
    {'name':'ENGLISH','locale': Locale('en','GB')},
    {'name':'FRENCH','locale': Locale('fr','FR')},
    {'name':'YORUBA','locale': Locale('y','YO')},
    {'name':'IRISH','locale': Locale('en','IE')},
    {'name':'ESPANYOL','locale': Locale('es','ES')},
    {'name':'ITALIAN','locale': Locale('it','IT')},
    {'name':'PORTUGUESE','locale': Locale('pt','PT')},
    {'name':'普通话 中文','locale': Locale('zh','CN')},
    {'name':'GERMAN','locale': Locale('de','DE')},
  ];

  updatelanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  builddialog(BuildContext context){
    showDialog
      (context: context,
        builder: (builder) {
          return AlertDialog(
              title: Text('Choose a language'.tr),
              content: Container(
                width: double.maxFinite,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  GestureDetector(
                            onTap: (){
                              print(locale[index]['name']);
                              updatelanguage(locale[index]['locale']);
                            },
                            child: Text(locale[index]['name'])),
                      );
                    },
                    separatorBuilder: (context, index){
                      return Divider(
                        color: Colors.blue,
                      );
                    },
                    itemCount: locale.length
                ),
              )

          );
        });
  }

  TextEditingController new_latitude = TextEditingController();
  TextEditingController new_longitude = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hey! What would you like to do today?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewAttendance()),
                  );
                },
                child: Text('View Students Attendance'),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(220, 30)), // Adjust the Size as needed
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeGeofence(),
                    ),
                  );
                },
                child: Text('Change Class Location'),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(220, 30)), // Adjust the Size as needed
                ),
              ),
              ElevatedButton(onPressed: (){
                builddialog(context);
              },
                child: Text('Change Language'),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(220, 30)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


