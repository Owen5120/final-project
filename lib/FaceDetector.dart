import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io' as io;

class FaceDetector extends StatefulWidget {
  const FaceDetector({super.key});

  @override
  State<FaceDetector> createState() => _FaceDetectorState();
}

class _FaceDetectorState extends State<FaceDetector> {
  TextEditingController UserName = TextEditingController();
  String Uname = '';
  String faceDetectedMessage = '';
  bool faceDetected = false;
  @override
  void initState() {
    super.initState();

    // Disable screen rotation for this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Re-enable screen rotation when the screen is disposed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  io.File? _imageFile;
//image picker package handling image selection
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      setState(() {
        _imageFile = io.File(file.path);
      });
    }
  }

  String imageUrl = '';

  Future<void> _uploadImage(BuildContext context) async {
    final Reference referenceRoot = FirebaseStorage.instance.ref();
    final Reference referenceDirUsers = referenceRoot.child('Users');
    try {
      final String fileName = Uname; // Change the filename as needed
      final Reference referenceImageToUpload = referenceDirUsers.child(fileName);

      final UploadTask task = referenceImageToUpload.putFile(_imageFile!, SettableMetadata(contentType: 'image/png'),);
      final TaskSnapshot snapshot = await task.whenComplete(() {});

      imageUrl = await snapshot.ref.getDownloadURL();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File Uploaded to Firebase Successfully!'),
        ),
      ); // Showing a Snackbar to indicate that the file was uploaded successfully

    } catch (e) {
      // Handle the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading file to Firebase: $e'),
        ),
      );
    }
  }
//detection using googleML kit
  Future<void> processImage(InputImage inputImage) async{
    final faceDetector = GoogleMlKit.vision.faceDetector(
        FaceDetectorOptions(
          enableClassification: true,
          enableTracking: true,
          enableLandmarks: true,
          enableContours: true,
        )
    );
    final InputImage inputImage = InputImage.fromFile(_imageFile!);
    final List<Face> faces = await faceDetector.processImage(inputImage);

    // Add a variable to track if a face was detected
    bool faceDetected = false;

    for(Face face in faces){
      faceDetected = true;
      break;
    }

    // Print a message on the screen depending on whether a face was detected
    if (faceDetected) {
      print("Face detected");
      await _uploadImage(context);
      //ScaffoldMessenger.of(context).showSnackBar(
      //SnackBar(
      // content: Text('File uploaded to Firebase successfully'),),);
    } else {
      print("Face not detected");
      // ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar(
      //   content: Text('Face not detected!'),),);
    }

    faceDetector.close();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(80),
            child: Builder(
              // Wrap Scaffold with Builder to get the correct context
              builder: (BuildContext context) {
                return Column(
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 250,
                      child: _imageFile != null
                          ? Image.file(_imageFile!) // Use Image.file from package:flutter
                          : Center(
                        child: Text('No image selected'),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          icon: Icon(Icons.image),
                        ),
                        IconButton(
                          onPressed: () => _pickImage(ImageSource.camera),
                          icon: Icon(Icons.camera_alt),
                        ),
                        if (_imageFile != null)
                          IconButton(
                            onPressed: () async {
                              Uname = UserName.text;
                              final InputImage inputImage = InputImage.fromFile(_imageFile!);
                              await processImage(inputImage);
                              //await _uploadImage(context);
                              // Pass context here
                            },
                            icon: Icon(Icons.upload),
                          ),
                      ],
                    ),
                    if (_imageFile != null)
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Enter your name',
                        ),
                        controller: UserName,
                      ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Note: Please ensure that the face image to be registered is captured under well-lit conditions',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}