import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class TestFirebaseRetrieveImage extends StatefulWidget {
  const TestFirebaseRetrieveImage({Key? key}) : super(key: key);

  @override
  State<TestFirebaseRetrieveImage> createState() =>
      _TestFirebaseRetrieveImageState();
}

class _TestFirebaseRetrieveImageState extends State<TestFirebaseRetrieveImage> {
  Uint8List? _downloadedImage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImageFromFirebase();
  }

  Future<void> _loadImageFromFirebase() async {
    String fileName = 'Owen';
    try {
      Reference reference =
      FirebaseStorage.instance.ref().child('Users').child(fileName);
      final FullMetadata metadata = await reference.getMetadata();

      // Check if the content type is an image
      if (metadata.contentType == 'image/png') {
        final Uint8List? imageData = await reference.getData(metadata.size!);
        setState(() {
          _downloadedImage = imageData;
          _isLoading = false;
        });
      } else {
        print('The file is not an image.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 160, left: 65, bottom: 40),
          child: Column(
            children: <Widget>[
              Container(
                width: 250,
                height: 250,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : _downloadedImage != null
                    ? Image.memory(_downloadedImage!)
                    : Text('No image found'),
              ),
              // Your image picking widgets here
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(TestFirebaseRetrieveImage());
}
