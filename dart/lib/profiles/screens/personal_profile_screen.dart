import 'package:dart/common/api/route_address.dart';
import 'package:dart/common/api/token_request.dart';
import 'package:dart/common/local_storage/const.dart';

import 'package:dart/profiles/constants/boxes.dart';
import 'package:dart/profiles/constants/user.dart';

import 'package:dart/profiles/custom_widgets/screen_widget/profile_photo.dart';
import 'package:dart/profiles/custom_widgets/screen_widget/settings_bottom_sheet.dart';
import 'package:dart/profiles/custom_widgets/screen_widget/user_info_round_widget.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({super.key});

  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  final box = Boxes.getUserData();
  late int currentYear;
  File? _image;
  final picker = ImagePicker();

  /*--------------------- user form ------------------------*/
  String imageUrl =
      "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80";
  File? myImage;
  String name = "";
  String userName = "";
  int age = 0;
  String dob = "";
  String userBio = "";
  Color primaryColor = const Color.fromARGB(255, 81, 255, 200);
  List<String> interests = [];

  /*--------------------- Text controllers ------------------------*/

  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();
  TextEditingController dobController = TextEditingController();

/*----------------- Dummy data representing data retrieved from the server -------------------*/

  Map<String, dynamic> passedUserData = {
    'userImage':
        "https://cdn.pixabay.com/photo/2018/04/27/03/50/portrait-3353699_1280.jpg",
    'name': "Tom Holland",
    'username': "tom15",
    'phoneNum': "010123456789",
    'dob': "21/07/2001",
    'bio':
        "🌍 Explorer of both the world and my imagination. 📸 Capturing moments that matter. 🎨",
    'hobbies': ["Reading", "Cycling", "Coding", "Designing", "Travelling"],
  };

  /*-------------- api form ---------------------*/
  Map<String, dynamic> dataToPushtoServer = {};
  dynamic loggedUser;
  String? nId;

/* ---------------------------- widget method ---------------------------- */
  @override
  void initState() {
    super.initState();
    _requestPermissions();
    DateTime now = DateTime.now(); // Method to get current date
    currentYear = now.year;
    readUId();
    // getPersonalInfo();
    downloadAndCacheImage(passedUserData['userImage']);
  }

  @override
  void dispose() {
    userNameController.dispose();
    nameController.dispose();
    bioController.dispose();
    dobController.dispose();
    hobbiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // void refreshScreen() {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => const PersonalProfileScreen()));
    // }

    /*-------------------------- UI Start ---------------------------------------- */
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "Peak",
                style: TextStyle(
                    color: Color.fromARGB(255, 81, 54, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Tew",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                settingsBottomSheet(
                    context,
                    onDonePressed,
                    bioController,
                    dobController,
                    nameController,
                    userNameController,
                    hobbiesController);
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 25, bottom: 25),
          child: Column(
            children: [
              ProfilePhoto(
                tapOnProfilePhoto: tapOnProfilePhoto,
                userImage: myImage,
              ),
              UserInfoWidget(
                name: name,
                age: age,
                userBio: userBio,
                interests: interests,
              ),
            ],
          ),
        ),
      ),
    );
  }

/* ============================= method ============================= */
  /*-------------- read user id to load user data -------------------*/
  void readUId() async {
    nId = await storage.read(key: phoneNumberLS);
    loggedUser = box.get(nId.toString());
    await loadUserData(); // Loads all the data from serve if local cache is empty else from local cache/ storage

    //--------------Assigning values to the text controller of edit profile
    userNameController = TextEditingController(text: userName);
    nameController = TextEditingController(text: name);
    bioController = TextEditingController(text: userBio);
    dobController = TextEditingController(text: dob);
    hobbiesController = TextEditingController(
        text: interests.join(
            ', ')); // Concatanates List of Strings(i.e. combines list to one single string)
  }

  /*------------- load user data at the first place -----------------*/
  Future<void> loadUserData() async {
    if (loggedUser != null) {
      setState(() {
        name = loggedUser.name ??= passedUserData['name'];
        userName = loggedUser.userName ??= passedUserData['username'];
        age = loggedUser.dob == null
            ? int.parse(loggedUser.dob)
            : currentYear - int.parse(passedUserData['dob'].split('/')[2]);
        imageUrl = loggedUser.imageData ??= passedUserData['userImage'];
        dob = loggedUser.dob ??= passedUserData['dob'];
        userBio = loggedUser.bio ??= passedUserData['bio'];
        interests = loggedUser.hobbies ??= passedUserData['hobbies'];
      });
    } else if (loggedUser == null) {
      setState(() {
        imageUrl = passedUserData['userImage'];
        name = passedUserData['name'];
        userName = passedUserData['username'];
        age = currentYear - int.parse(passedUserData['dob'].split('/')[2]);
        userBio = passedUserData['bio'];
        dob = passedUserData['dob'];
        interests = passedUserData['hobbies'];
      });

      storeUserData(
        passedUserData['name'],
        passedUserData['username'],
        passedUserData['phoneNum'],
        passedUserData['dob'],
        passedUserData['bio'],
        passedUserData['hobbies'],
        passedUserData['userImage'],
      );
    }
  }

  /* --------------- Stores user's data in local cache/storage --------------- */
  void storeUserData(
    String name,
    String username,
    String phoneNum,
    String dob,
    String bio,
    dynamic hobbies,
    String userImage,
  ) async {
    UserData user = UserData(
      imageData: userImage,
      name: name,
      userName: username,
      phoneNumber: phoneNum,
      dob: dob,
      bio: bio,
      hobbies: hobbies,
    );
    final box = Boxes.getUserData();
    box.put(phoneNum, user);
  }

  /*--------------Function used to update the data after clicking done in edit profile sheet-------------------*/
  void updateUserData() async {
    UserData updatedUser = UserData(
      name: nameController.text == "" ? loggedUser.name : nameController.text,
      userName: userNameController.text == ""
          ? loggedUser.userName
          : userNameController.text,
      phoneNumber: loggedUser.phoneNumber,
      dob: dobController.text == "" ? loggedUser.dob : dobController.text,
      bio: bioController.text == " " ? loggedUser.bio : bioController.text,
      hobbies: hobbiesController.text.split(', ').isEmpty
          ? loggedUser.hobbies
          : hobbiesController.text.split(', '),
    );
    final box = Boxes.getUserData();
    //box.put(loggedUser.phoneNumber == "" ? nId : loggedUser.phoneNumber,
    //updatedUser);
    dataToPushtoServer = {
      'bio': bioController.text,
      'username': userNameController.text,
      'hobbies': hobbiesController.text,
      // 'interests': loggedUser.hobbies,
    };
    box.put(nId.toString(), updatedUser);
    loggedUser = box.get(nId);
    sendEditedProfile(dataToPushtoServer);

    setState(() {
      name = loggedUser.name ??= passedUserData['name'];
      userName = loggedUser.userName ??= passedUserData['username'];
      age = loggedUser.dob == null
          ? int.parse(loggedUser.dob)
          : currentYear - int.parse(passedUserData['dob'].split('/')[2]);
      imageUrl = loggedUser.imageData ??= passedUserData['userImage'];
      dob = loggedUser.dob ??= passedUserData['dob'];
      userBio = loggedUser.bio ??= passedUserData['bio'];
      interests = loggedUser.hobbies ??= passedUserData['hobbies'];
    });
  }

  /*------------- request photo access permission -----------------*/
  Future<void> _requestPermissions() async {
    final cameraPermissionStatus = await Permission.camera.status;
    if (cameraPermissionStatus.isDenied) {
      await Permission.storage.request();

      if (cameraPermissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (cameraPermissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      print("check camera permission");
    }

    final storagePermissionStatus = await Permission.photos.status;
    if (storagePermissionStatus.isDenied) {
      await Permission.photos.request();
      if (storagePermissionStatus.isDenied) {
        await openAppSettings();
      }
    } else if (storagePermissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      print("check storage permission");
    }
  }

  //read image
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        uploadImage(_image!);
      } else {
        print('------No image selected.------');
      }
    });
  }

  // take photo
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        uploadImage(_image!);
      } else {
        print('-----No image selected.------');
      }
    });
  }

  Future<void> downloadAndCacheImage(String imageURL) async {
    final cacheManager = DefaultCacheManager();

    //Download the image if not already cached
    final fileInfo = await cacheManager.getFileFromCache(imageURL);
    if (fileInfo == null || !fileInfo.file.existsSync()) {
      final myImage = await cacheManager.downloadFile(imageURL);
      if (myImage.file.existsSync()) {
        setState(() {
          this.myImage = myImage.file;
          print(myImage.file.path);
          print('--------${myImage.file.path}');
        });
        return;
      }
    }
    setState(() {
      myImage = fileInfo!.file;
    });
  }

  // upload photo to server
  Future<void> uploadImage(File imageFile) async {
    try {
      var sendImage = ApiService();
      final accessToken = await storage.read(key: accessTokenKeyLS);

      var formData = FormData({
        'file': MultipartFile(
          imageFile.path,
          filename: 'image.jpg',
        ),
      });
      Map<String, dynamic> imageData = {"image": formData};

      var response = await sendImage.postWithToken(
        accessToken: accessToken!,
        toUrl: "image",
        data: imageData,
      );

      if (response!.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void tapOnProfilePhoto() {
    {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Profile Photo'),
            content: const Text('select your photo'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  getImageFromCamera();
                  //here
                },
                child: const Text('camera'),
              ),
              TextButton(
                onPressed: () {
                  getImageFromGallery();
                  //here
                },
                child: const Text('gallery'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('close'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<List<int>?> compressImage(File image) async {
    final bytes = await image.readAsBytes();

    // Compress the image
    final compressedImage = img.decodeImage(bytes);
    if (compressedImage == null) {
      return null;
    }

    final compressedImageBytes = img.encodeJpg(compressedImage, quality: 50);

    return compressedImageBytes;
  }

  void getPersonalInfo() async {
    try {
      final getPersonData = ApiService();
      final accessToken = await storage.read(key: accessTokenKeyLS);

      final response =
          await getPersonData.requestWithToken(accessToken!, profileReceiveURL);

      final message = await getPersonData.tokenReponseCheck(response);

      if (message == 'success') {
        //save user's Personal data from Server

        if (response != null) {
          final phoneNumber = response.data['phone'];
          await storage.write(key: phoneNumberLS, value: phoneNumber);

          UserData loggedUser = UserData(
              name: response.data['nickname'],
              userName: "John Doe",
              phoneNumber: phoneNumber,
              dob: "21",
              bio: "",
              hobbies: ["Programming", "Travelling"]);

          final box1 = Boxes.getUserData();
          //To check if user is previously cached or not
          final isUserPreviouslyCached = box1.get(response.data['phone']);
          isUserPreviouslyCached != null
              ? null
              : box1.put(phoneNumber, loggedUser);

          print(
              '=================from loginscreen: ${box1.get(phoneNumber)?.name}');
        }
      }
    } catch (e) {
      debugPrintStack();
    }
  }

  void sendEditedProfile(Map<String, dynamic> data) async {
    final editedInfo = ApiService();
    final accessToken = await storage.read(key: accessTokenKeyLS);

    if (accessToken == null) {
      print('failed bringing accessToken');
      return;
    }

    final responseAfterSent = await editedInfo.postWithToken(
      accessToken: accessToken,
      toUrl: profileSendURL,
      data: data,
    );
    print('----------------right here is the acccessToken--------$accessToken');
    final message = await editedInfo.tokenReponseCheck(responseAfterSent);

    if (message == 'success') {
      print('succeed sending edited profile to server');
      print('succeed sending edited profile to server');
      print('succeed sending edited profile to server');
    } else {
      print("failed message : $message");
      print("failed message : $message");
      print("failed message : $message");
    }
  }

/* --------------- editing finished --------------- */
  void onDonePressed() async {
    updateUserData();
    Get.back();
  }
}
