import 'package:dart/profiles/custom_widgets/my_textfield.dart';
import 'package:dart/profiles/custom_widgets/small_btn.dart';
import 'package:flutter/material.dart';

/* ================ bottom sheet button for edting profile info ================ */

class BottomSheetButton extends StatelessWidget {
  final VoidCallback doneButtonPressed;
  final TextEditingController nameController,
      bioController,
      hobbiesController,
      dobController,
      userNameController;

  const BottomSheetButton({
    super.key,
    required this.doneButtonPressed,
    required this.bioController,
    required this.dobController,
    required this.hobbiesController,
    required this.nameController,
    required this.userNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () {
          /*------------- Bottom sheet for editing profile -------------------- */
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
                  height: MediaQuery.of(context).size.height / 2,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(60)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                onPressed: () {
                                  doneButtonPressed;
                                },
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
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
              );
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          );
        },
        child: const Text(
          "Edit your profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
