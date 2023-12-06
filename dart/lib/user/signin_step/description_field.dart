import 'package:dart/profiles/custom_widgets/my_textfield.dart';
import 'package:dart/user/signin_step/hobbies_field.dart';
import 'package:dart/user/signin_step/password_field.dart';
import 'package:dart/user/common/const/color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DescriptionField extends StatefulWidget {
  const DescriptionField({super.key});

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  TextEditingController descriptionController = TextEditingController();
  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    descriptionController.addListener(_checkButtonState);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void _checkButtonState() {
    setState(() {
      isButtonDisabled = descriptionController.text.length < 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = const TextStyle(
      color: textColor,
      // fontSize: isOnKeyBoard ? 45 : 30,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Add something about you!", style: textstyle),
            const SizedBox(height: 10),
            const Text(
              "Let's spice up your profile! Tell us a bit about yourself.",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color.fromARGB(255, 66, 66, 66)),
            ),
            CustomTextField(
              hintText:
                  "Let's break the ice! Share a quick bio and let the fun begin.",
              controller: descriptionController,
              obscureText: false,
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 50, vertical: 5),
              decoration: BoxDecoration(
                color: !isButtonDisabled ? textColor : Colors.grey[500],
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: TextButton(
                onPressed: !isButtonDisabled ? () => nextPage() : null,
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextPage() {
    Get.to(HobbiesField());
  }
}
