import 'RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ML/Recognition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static Map<String,Recognition> registered = Map();
  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(margin: const EdgeInsets.only(top: 160),child: Image.asset("images/logo.png",width: screenWidth-40,height: screenWidth-40,)),
          Container(
            margin: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistrationScreen()));
                },
                  style: ElevatedButton.styleFrom(minimumSize: Size(screenWidth-30, 50)), child: const Text("Register"),),
                Container(height: 20,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
