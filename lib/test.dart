import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io' as io;

class TestFirebaseRetrieveImage extends StatefulWidget {
  const TestFirebaseRetrieveImage({super.key});

  @override
  State<TestFirebaseRetrieveImage> createState() => _TestFirebaseRetrieveImageState();
}

class _TestFirebaseRetrieveImageState extends State<TestFirebaseRetrieveImage> {
  Future<Uint8List?> _faceMatch() async{
    String fileName = 'Owen';
    final reference = FirebaseStorage.instance.ref().child('Users');
    final listResult = await reference.listAll();

    for (final item in listResult.items) {
      if (item.name == fileName) {
        // If you find the file, call the `getData()` method to download the file.
        final file1 = await item.getData();
        // Return the downloaded file.
        return file1;
      }
    }
    return null;
  }
  io.File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      setState(() {
        _imageFile = io.File(file.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 160,left:65,bottom: 40),
          child: Column(
            children: <Widget>[
              Container(
                width: 250,
                height: 250,
                child: FutureBuilder<Uint8List?>(
                  future: _faceMatch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // Display the downloaded file.
                      return Image.memory(snapshot.data!);
                    } else if (snapshot.hasError) {
                      // Display an error message.
                      return Text('${snapshot.error}');
                    } else {
                      // Display a loading indicator.
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Container(
                width: 250,
                height: 250,
                child: _imageFile != null
                    ? Image.file(_imageFile!) // Use Image.file from package:flutter
                    : Center(
                  child: Text('No image selected'),
                ),
              ),
              IconButton(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: Icon(Icons.camera_alt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}