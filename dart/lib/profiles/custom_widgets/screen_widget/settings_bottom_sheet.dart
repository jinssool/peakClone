import 'package:dart/home/sign_off_screen.dart';
import 'package:dart/profiles/custom_widgets/screen_widget/edit_profile_bottom_sheet.dart';
import 'package:dart/profiles/custom_widgets/settings-options-button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void settingsBottomSheet(BuildContext context,
    VoidCallback onDonePressed,
    TextEditingController bioController,
    TextEditingController dobController,
    TextEditingController nameController,
    TextEditingController userNameController,
    TextEditingController hobbiesController,) {
  Size screenSize = MediaQuery
      .of(context)
      .size;
  List<String> items = [
    'Invite Friends',
    'Edit profile',
    'Security',
    'Help',
    'About',
    'Sign out',
  ];

  List<IconData> icons = [
    Icons.person_add_alt,
    Icons.edit_note,
    Icons.lock_person,
    Icons.help_outline,
    Icons.info_outline,
    Icons.logout,
  ];

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        height: screenSize.height * 0.7,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Color.fromARGB(255, 239, 230, 255),
        ),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 50,
              margin: const EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.black),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                SettingsButton(
                    icon: icons[0], label: items[0], onPressed: () {}),
                SettingsButton(
                  icon: icons[1],
                  label: items[1],
                  onPressed: () {
                    print("Edit button pressed");
                    Navigator.pop(context);
                    editProfileBottomSheet(
                        context,
                        onDonePressed,
                        bioController,
                        dobController,
                        nameController,
                        userNameController,
                        hobbiesController);
                  },
                ),
                SettingsButton(
                    icon: icons[2], label: items[2], onPressed: () {}),
                SettingsButton(
                    icon: icons[3], label: items[3], onPressed: () {}),
                SettingsButton(
                    icon: icons[4], label: items[4], onPressed: () {}),
                SettingsButton(
                    icon: icons[5],
                    label: items[5],
                    onPressed: () {
                      showDialog(context: context,
                        barrierDismissible: true, // when user touched outside of pop-up
                        builder: (BuildContext context){
                          return AlertDialog(
                            content: const Text('Are you sure you want to sign-off of PeakTew?'),
                            actions: [
                              TextButton(onPressed: () {
                                Get.offAll(SignOffScreen());
                               }, child: const Text('Yes')),
                              TextButton(onPressed: (){
                                Get.back();
                              }, child: const Text('Cancel')),
                            ],
                            elevation: 24,

                          );
                        },);}
                    ),
              ],
            )
          ],
        ),
      );
    },
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
  );
}
