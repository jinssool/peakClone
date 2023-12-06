// import 'package:dart/common/local_storage/const.dart';
// import 'package:dart/profiles/constants/boxes.dart';
// import 'package:dart/profiles/constants/user.dart';
// import 'package:dart/profiles/custom_widgets/my_textfield.dart';
// import 'package:dart/profiles/custom_widgets/small-btn.dart';
// import 'package:dart/profiles/custom_widgets/user_info.dart';

// import 'package:flutter/material.dart';

// class PersonalProfileScreen extends StatefulWidget {
//   const PersonalProfileScreen({super.key});

//   @override
//   State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
// }

// class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
//   final box = Boxes.getUserData();
//   late int currentYear;

//   String userImage =
//       "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80";
//   String name = "";
//   String userName = "";
//   int age = 0;
//   String dob = "";
//   String userBio = "";
//   Color primaryColor = const Color.fromARGB(255, 81, 255, 200);
//   List<String> interests = [];

//   /*---------------------Text controllers------------------------*/
//   TextEditingController userNameController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController bioController = TextEditingController();
//   TextEditingController hobbiesController = TextEditingController();
//   TextEditingController dobController = TextEditingController();
//   /*---------------------Text controllers------------------------*/
//   List<String> userData = [];
//   Color checkColorContrast(Color color) {
//     double luminance =
//         (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
//     return luminance > 0.5 ? Colors.black : Colors.white;
//   }

// /*----------------- Dummy data representing data retrieved from the server -------------------*/
//   Map<String, dynamic> passedUserData = {
//     'name': "Tom Holland",
//     'username': "tom15",
//     'phoneNum': "010123456789",
//     'dob': "21/07/2001",
//     'bio':
//         "🌍 Explorer of both the world and my imagination. 📸 Capturing moments that matter. 🎨",
//     'hobbies': ["Reading", "Cycling", "Coding", "Designing", "Travelling"],
//   };

//   /*-------------- Dummy data representing data retrieved from the server ---------------------*/
//   dynamic loggedUser;
//   String? nId;

// /*-------------Load user's data either from client cache or server-----------------*/
//   Future<void> loadUserData() async {
//     if (loggedUser != null) {
//       setState(() {
//         name = loggedUser.name;
//         userName = loggedUser.userName;
//         age = int.parse(loggedUser.dob);
//         dob = loggedUser.dob;
//         userBio = loggedUser.bio;
//         interests = loggedUser.hobbies;
//       });
//     } else if (loggedUser == null) {
//       setState(() {
//         name = passedUserData['name'];
//         userName = passedUserData['username'];
//         age = currentYear - int.parse(passedUserData['dob'].split('/')[2]);
//         userBio = passedUserData['bio'];
//         dob = passedUserData['dob'];
//         interests = passedUserData['hobbies'];
//       });

//       storeUserData(
//           passedUserData['name'],
//           passedUserData['username'],
//           passedUserData['phoneNum'],
//           passedUserData['dob'],
//           passedUserData['bio'],
//           passedUserData['hobbies']);
//     }
//   }

//   /*-------------Load user's data either from client cache or server-----------------*/

//   /*---------------Stores user's data in local cache/storage */

//   void storeUserData(String name, String username, String phoneNum, String dob,
//       String bio, dynamic hobbies) {
//     UserData user = UserData(
//         name: name,
//         userName: username,
//         phoneNumber: phoneNum,
//         dob: dob,
//         bio: bio,
//         hobbies: hobbies);
//     final box = Boxes.getUserData();
//     box.put(phoneNum, user);
//   }

// /*--------------Function used to update the data after clicking done in edit profile sheet-------------------*/
//   void updateUserData() {
//     UserData updatedUser = UserData(
//       name: nameController.text == "" ? loggedUser.name : nameController.text,
//       userName: userNameController.text == ""
//           ? loggedUser.userName
//           : userNameController.text,
//       phoneNumber: loggedUser.phoneNumber,
//       dob: dobController.text == "" ? loggedUser.dob : dobController.text,
//       bio: bioController.text,
//       hobbies: hobbiesController.text.split(',').isEmpty
//           ? loggedUser.hobbies
//           : hobbiesController.text.split(','),
//     );
//     final box = Boxes.getUserData();
//     //box.put(loggedUser.phoneNumber == "" ? nId : loggedUser.phoneNumber,
//     //updatedUser);

//     box.put(nId.toString(), updatedUser);
//     loggedUser = box.get(nId);
//     print(loggedUser.name);
//     setState(() {
//       name = loggedUser.name;
//       userName = loggedUser.userName;
//       age = int.parse(loggedUser.dob);
//       dob = loggedUser.dob;
//       userBio = loggedUser.bio;
//       interests = loggedUser.hobbies;
//     });

//     /*----------- Add function to update the data in the server ------------------------ */

//     /*----------- Add function to update the data in the server ------------------------ */
//   }
//   /*--------------Function used to update the data after clicking done in edit profile sheet-------------------*/

//   @override
//   void initState() {
//     super.initState();
//     DateTime now = DateTime.now(); // Method to get current date
//     currentYear = now.year;
//     readUId();
//     //loggedUser = box.get(passedUserData['phoneNum']);

//     loggedUser = box.get(nId.toString());
//   }

//   void readUId() async {
//     nId = await storage.read(key: phoneNumberLS);
//     loggedUser = box.get(nId.toString());
//     await loadUserData(); // Loads all the data from serve if local cache is empty else from local cache/ storage

//     //--------------Assigning values to the text controller of edit profile
//     userNameController = TextEditingController(text: userName);
//     nameController = TextEditingController(text: name);
//     bioController = TextEditingController(text: userBio);
//     dobController = TextEditingController(text: dob);
//     hobbiesController = TextEditingController(
//         text: interests.join(
//             ',')); // Concatanates List of Strings(i.e. combines list to one single string)
//   }

//   @override
//   void dispose() {
//     userNameController.dispose();
//     nameController.dispose();
//     bioController.dispose();
//     dobController.dispose();
//     hobbiesController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     void refreshScreen() {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => const PersonalProfileScreen()));
//     }

//     String personalInfo = ModalRoute.of(context)!.settings.arguments.toString();
//     userData = personalInfo.split('/');
//     Color iconColor = checkColorContrast(primaryColor);
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigator.pop(context);
//           onEditPressed();
//         },
//         tooltip: "Home",
//         backgroundColor: primaryColor,
//         child: Icon(
//           Icons.home,
//           color: iconColor,
//           size: 25,
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.only(bottom: 25),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               height: 500,
//               alignment: Alignment.bottomCenter,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(userImage),
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(50),
//                     bottomRight: Radius.circular(50)),
//               ),
//               child: Container(
//                 width: double.infinity,
//                 alignment: Alignment.bottomCenter,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(50),
//                       bottomRight: Radius.circular(50)),
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.transparent,
//                       Colors.black.withOpacity(0.2),
//                       Colors.black.withOpacity(0.3),
//                       Colors.black.withOpacity(0.7),
//                     ],
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 30.0),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           name.split(' ')[0],
//                           style: TextStyle(
//                             color: primaryColor,
//                             fontSize: 45,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         name.split(' ').length == 2
//                             ? Text(
//                                 name.split(' ')[1],
//                                 style: TextStyle(
//                                   color: primaryColor,
//                                   fontSize: 45,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               )
//                             : const Text(""),
//                       ]),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               child: Column(
//                 children: [
//                   UserInfoDisplay(
//                     name: "@$userName",
//                     age: "$age yo",
//                     userBio: userBio,
//                     interests: interests,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: TextButton(
//                     onPressed: () {
//                       /*------------- Bottom sheet for editing profile -------------------- */
//                       showModalBottomSheet(
//                         isScrollControlled: true,
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Padding(
//                             padding: EdgeInsets.only(
//                               bottom: MediaQuery.of(context).viewInsets.bottom,
//                             ),
//                             child: Container(
//                               padding:
//                                   const EdgeInsets.fromLTRB(20, 40, 20, 30),
//                               height: MediaQuery.of(context).size.height / 2,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(60)),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       alignment: Alignment.centerRight,
//                                       width: double.infinity,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           const Text(
//                                             "Edit your profile",
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           RoundedSmallBtn(
//                                               title: "Done",
//                                               onPressed: () async {
//                                                 updateUserData();
//                                                 Navigator.pop(context);
//                                               },
//                                               backgroundColor: Colors.black,
//                                               textColor: Colors.white),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     CustomTextField(
//                                       label: "Name",
//                                       hintText: "Enter your name",
//                                       controller: nameController,
//                                       obscureText: false,
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     CustomTextField(
//                                       label: "Username",
//                                       hintText: "Enter your username",
//                                       controller: userNameController,
//                                       obscureText: false,
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     CustomTextField(
//                                       label: "Your bio",
//                                       hintText: "Write your bio",
//                                       controller: bioController,
//                                       obscureText: false,
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     CustomTextField(
//                                       label: "Your Date of birth",
//                                       hintText: "DD/MM/YYYY",
//                                       controller: dobController,
//                                       obscureText: false,
//                                     ),
//                                     const SizedBox(height: 15),
//                                     CustomTextField(
//                                       label: "Your hobbies/ interests",
//                                       hintText: "Enter your hobbies",
//                                       controller: hobbiesController,
//                                       obscureText: false,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(30))),
//                       );
//                     },
//                     child: const Text(
//                       "Edit your profile",
//                       style: TextStyle(color: Colors.white),
//                     ))),
//           ],
//         ),
//       ),
//     );
//   }

//   void onEditPressed() async {
//     final name = await storage.read(key: nameLS);
//     final phoneNumber = await storage.read(key: birthdayLS);
//     final age = await storage.read(key: phoneNumberLS);

//     print(name);
//     print(phoneNumber);
//     print(age);
//   }

//   void onDonePressed() async {
//     await storage.delete(key: nameLS);
//     await storage.delete(key: birthdayLS);
//     await storage.delete(key: phoneNumberLS);

//     await storage.write(key: nameLS, value: loggedUser.name);
//     await storage.write(key: birthdayLS, value: loggedUser.dob);
//     await storage.write(key: phoneNumberLS, value: loggedUser.phoneNumber);
//   }
// }
