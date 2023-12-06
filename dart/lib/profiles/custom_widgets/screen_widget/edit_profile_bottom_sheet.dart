import 'package:dart/profiles/custom_widgets/small_btn.dart';
import 'package:flutter/material.dart';
import 'package:dart/profiles/custom_widgets/my_textfield.dart';

void editProfileBottomSheet(
  BuildContext context,
  VoidCallback onDonePressed,
  TextEditingController bioController,
  TextEditingController dobController,
  TextEditingController nameController,
  TextEditingController userNameController,
  TextEditingController hobbiesController,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 5,
                width: 50,
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Edit your profile",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RoundedSmallBtn(
                      title: "Done",
                      onPressed: onDonePressed,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        label: "Name",
                        hintText: "Enter your name",
                        controller: nameController,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        label: "Username",
                        hintText: "Enter your username",
                        controller: userNameController,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        label: "Your bio",
                        hintText: "Write your bio",
                        controller: bioController,
                        maxLines: 3,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        label: "Your Date of birth",
                        hintText: "DD/MM/YYYY",
                        controller: dobController,
                        obscureText: false,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Your hobbies/ interests",
                        hintText: "Enter your hobbies",
                        controller: hobbiesController,
                        obscureText: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
  );
}
