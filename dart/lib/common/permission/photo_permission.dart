import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class AccessPhoto {
  File? _image;
  final picker = ImagePicker();

  Future<void> _requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    if (cameraStatus.isGranted && storageStatus.isGranted) {
      print('Permission granted for camera and storage');
      return;
    }

    if (cameraStatus.isRestricted) {
      print("Camera permission has been denied before");
      await Permission.camera.request();
    }
    if (cameraStatus.isPermanentlyDenied) {
      print("Camera permission has been denied before permanently");
      openAppSettings();
    }
    if (storageStatus.isRestricted) {
      print("storage permission has been denied before");
      await Permission.storage.request();
    }

    if (storageStatus.isPermanentlyDenied) {
      print("Storage permission has been denied before permanently");
      openAppSettings();
    }

    if (storageStatus.isRestricted && cameraStatus.isRestricted) {
      print('Permission is rejected for camera or storage');
    }

    print("!!!!!!!!something went wrong!!!!!!!!!!!!");
  }

  //read image
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('------No image selected.------');
    }
  }

  // take photo
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('-----No image selected.------');
    }
  }

  // upload photo to server
  Future uploadImage() async {
    if (_image != null) {
      //_image!.path
    }
  }
}
