import 'package:flutter/material.dart';
import 'geofencing.dart';
import 'HomeScreen.dart';
import 'package:get/get.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hey! What would you like to do today?'.tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              Container(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icon/Homepage Wallpaper (1).png"), //
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  }, child: Text('   Register Face   '.tr)
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GeolocationApp()), //Check this out!!
                    );
                  }, child: Text('Mark Attendance'.tr)
              ),
              ElevatedButton(onPressed: (){
                builddialog(context);
              },
                  child: Text('Change Language'.tr)),
              ElevatedButton(
                  onPressed: (){}, child: Text('View Attendance'.tr)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
