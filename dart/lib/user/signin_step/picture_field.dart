import 'dart:io';

import 'package:dart/user/common/const/color.dart';
import 'package:dart/user/common/main_layout.dart';
import 'package:dart/user/signin_step/description_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class PictureField extends StatefulWidget {
  const PictureField({super.key});

  @override
  State<PictureField> createState() => _PictureFieldState();
}

class _PictureFieldState extends State<PictureField> {
  final FaceDetector _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
    performanceMode: FaceDetectorMode.fast,
  ));

  final bool _canProcess = true;
  bool _isBusy = false;
  bool _isPerson = false;
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = const TextStyle(
      color: textColor,
      // fontSize: isOnKeyBoard ? 45 : 30,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    );
    return MainLayout.white(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Text(
                "Choose your profile picture",
                style: textstyle,
              ),
              const SizedBox(height: 10),
              const Text(
                "Select your profile picture and make it uniquely yours.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 66, 66, 66)),
              ),
              const SizedBox(height: 15),
              _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _image!,
                        width: 350,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/img/blank-profile-pic.png")),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.8,
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 50, vertical: 5),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: TextButton(
                    onPressed: getImageFromGallery,
                    child: const Text(
                      "Select your picture",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.8,
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 50, vertical: 5),
                decoration: BoxDecoration(
                  color: _isPerson ? textColor : Colors.grey[500],
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: TextButton(
                  onPressed:
                      (_image != null && _isPerson) ? () => nextPage() : null,
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          )),
    ]);
  }

  Future<void> _processImage(File image) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    try {
      final selectedImage = InputImage.fromFilePath(image.path);
      final List<Face> faces = await _faceDetector.processImage(selectedImage);
      print("=====================================${faces.length}");
      if (faces.isNotEmpty && faces.length <= 1) {
        setState(() {
          _isPerson = true;
        });
        print("I am really a person===========================");
      } else {
        setState(() {
          _isPerson = false;
        });
        print("I am not a personnn=========");
      }
    } finally {
      _isBusy = false;
    }
  }

  //read image
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _processImage(File(pickedFile.path));

      print("===================isPerson?:$_isPerson===================");
    } else {
      print('------No image selected.------');
    }
  }

  void nextPage() {
    Get.to(const DescriptionField());
  }
}
