import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'MarkAttendaceForLectures.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:camera/camera.dart';
import 'stafflogin.dart';
import 'staffsignup.dart';
import 'package:get/get.dart';
late List<CameraDescription> cameras;
Future main() async
{
 WidgetsFlutterBinding.ensureInitialized();
 await UserSheetsApi.init();
 await UserSheetsApi1.init();
 await UserSheetsApi2.init();
 await UserSheetsApi3.init();
 await UserSheetsApi4.init();
 await UserSheetsApi5.init();
 cameras = await availableCameras();
 // Initialize the Firebase app with the options.
 final FirebaseOptions options = FirebaseOptions(
  apiKey: 'AIzaSyCU_SsAE7bt4YlK7gRATII1_QDUPkHzX3c',
  projectId: 'facerecognitionattendanc-97cef',
  appId: '1:163699839593:android:fbdec498a86d1ee07188f8',
  messagingSenderId: '163699839593',
     storageBucket: 'gs://facerecognitionattendanc-97cef.appspot.com',
     );

 // Initialize the Firebase app with the options.
 await Firebase.initializeApp(options: options);
  runApp(const Login());
}
