import 'dart:io';
import 'package:flutter/material.dart';

import '../../common/api/request.dart';
import '../../common/api/route_address.dart';
import '../common/const/color.dart';
import '../common/main_layout.dart';
import '../common/widget/input_reqeust_button.dart';
import '../../user/common/regular_expression.dart';

class PhoneNumberFindField extends StatefulWidget {
  const PhoneNumberFindField({
    super.key,
  });

  @override
  State<PhoneNumberFindField> createState() => _PhoneNumberFieldFindState();
}

class _PhoneNumberFieldFindState extends State<PhoneNumberFindField> {
  String phoneNumber = '';
  String? errorText;
  final _phoneNumberFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hasError = false;
  bool success = false;
  String email = '';
  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isOnKeyBoard = MediaQuery.of(context).viewInsets.bottom == 0;
    TextStyle textstyle = const TextStyle(
      color: textColor,
      // fontSize: isOnKeyBoard ? 45 : 30,
      fontSize: 45,
      fontWeight: FontWeight.bold,
    );

    return MainLayout.white(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "What is your",
                style: textstyle,
              ),
              Text(
                "phone number?",
                style: textstyle,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Please provide your phone number, it will be used for finding your account email.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 66, 66, 66)),
              )
            ],

          ),
        ),
        Form(
          key: _formKey,
          child: BottmFieldRequest(
            keyboardOn: isOnKeyBoard,
            hasError: hasError,
            keyboardType: TextInputType.phone,
            onChanged: onChanged,
            hintText: 'example : 010-xxxx-xxxx',
            errorText: errorText,
            validator: (value) => value?.validatePhoneNumber(
              _phoneNumberFocusNode,
              value,
            ),
            phoneNumberFocusNode: _phoneNumberFocusNode,
            onNextPressed: validationCheck,
          ),
        ),
        success ==false && !email.isEmpty ? Text("Your account is ${email}", //after getting email from server, it will show.
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color.fromARGB(255, 66, 66, 66)),
        ):Container(),
      ],
    );
  }

  /* -------------------- methods ------------------- */

  // Called when the input field value changes.
  void onChanged(String val) {
    if (_formKey.currentState!.validate()) {
      hasError = false;
    } else {
      hasError = true;
    }
    setState(() {
      phoneNumber = val;
    });
  }

  // Initiates the validation process for phone number.
  void validationCheck() async {
    final ip = Platform.isAndroid ? androidEmulatorIP : iosSimulatorIP;
    final findAccount = PreApiService();
    final response = await findAccount.request(phoneNumber, ip + findURL); //Backend
    final message = await findAccount.reponseMessageCheck(response);

    // if (message == 'success') {
    //   success = true;
    //   if(response != null){
    //   email = response.data;
    // }}
    setState(() {
      errorText = 'Account does not exist. Please proceed with sign up.';
    });
  }

  // Check if the form input is valid and proceed accordingly.

/* -------------------- methods ------------------- */
}
