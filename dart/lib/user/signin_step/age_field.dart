import 'package:auto_size_text/auto_size_text.dart';
import 'package:dart/user/common/widget/next_button.dart';

import 'package:dart/user/signin_step/picture_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dart/common/local_storage/const.dart';
import 'package:get/get.dart';
import '../common/const/color.dart';
import '../common/main_layout.dart';
import '../common/widget/top_text.dart';

class AgeField extends StatefulWidget {
  final TextStyle textstyle = const TextStyle(
    color: textColor,
    fontSize: 50,
    fontWeight: FontWeight.bold,
  );

  const AgeField({
    super.key,
  });

  @override
  State<AgeField> createState() => _AgeFieldState();
}

class _AgeFieldState extends State<AgeField> {
  int age = 0;
  String birthDay = '';
  bool error = true;

  Map<String, String> userInfo = {};
  final _ageFocusNode = FocusNode();

  late DateTime today;

  @override
  void initState() {
    today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    super.initState();
  }

  @override
  void dispose() {
    _ageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bool isOnKeyBoard = MediaQuery.of(context).viewInsets.bottom == 0;

    TextStyle textstyle = const TextStyle(
      color: textColor,
      // fontSize: isOnKeyBoard ? 45 : 30,
      fontSize: 45,
      fontWeight: FontWeight.bold,
    );

    return MainLayout.white(
      floatingActionButton: FloatingActionButton(
          autofocus: true,
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.calendar_month_outlined,
            color: loginButtonColor,
          ),
          onPressed: () {
            error = false;
            showCupertinoDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.grey[100],
                    height: MediaQuery.of(context).size.height / 3,
                    child: CupertinoDatePicker(
                      minimumDate: DateTime(1950, 1, 1),
                      maximumDate: DateTime(2009, 12, 31),
                      initialDateTime: DateTime(2000, 1, 1),
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime date) => onChanged(date),
                    ),
                  ),
                );
              },
            );
          }),
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TopText(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  "What's your",
                  style: textstyle,
                ),
                Text(
                  "Age?",
                  style: textstyle,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Tap the floating action button to choose your date of birth.",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromARGB(255, 66, 66, 66)),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  error ? "" : ('Age : $age yo'),
                  style: textstyle,
                  maxLines: 3,
                  maxFontSize: 30,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                SizedBox(
                  child: NextButton(
                    buttonText: 'Continue',
                    onPressed: validInputCheck,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /* -------------------- methods ------------------- */

  // Called when the input field value changes.
  void onChanged(DateTime val) {
    setState(() {
      int gap = today.difference(val).inDays;
      age = gap ~/ 365;
      birthDay = '${val.year}-${val.month}-${val.day}';
    });
  }

  // Navigate to the next screen with the collected data.
  void nextPage() {
    Get.to(const PictureField());
  }

  // Check if the form input is valid and proceed accordingly.
  void validInputCheck() async {
    if (error) {
      setState(() {}); // Refresh the UI to show validation errors.
    } else {
      await storage.write(key: birthdayLS, value: birthDay);
      nextPage(); // Proceed to the next screen.
    }
  }

  /* -------------------- methods ------------------- */
}
