import 'dart:async';
import 'dart:io';
import 'package:dart/common/local_storage/const.dart';
import 'package:dart/user/signin_step/mail_field.dart';
import 'package:dart/user/signin_step/name_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/api/request.dart';
import '../../common/api/route_address.dart';
import '../common/const/color.dart';
import '../common/main_layout.dart';
import '../common/widget/input_reqeust_button.dart';
import '../../user/common/regular_expression.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({
    super.key,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  String phoneNumber = '';
  String? errorText;
  final _phoneNumberFocusNode = FocusNode();
  bool phoneNumIn = false;
  TextEditingController phoneFieldController = TextEditingController();
  String? smsCode;
  late PhoneAuthCredential _credential;
  late final String verificationId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hasError = false;
  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print(mobile);
    auth.verifyPhoneNumber(
      phoneNumber: mobile,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) async {
        print(authCredential);
        auth.signInWithCredential(authCredential).then((_) => nextPage());
        await storage.write(key: phoneNumberLS, value: phoneNumber);
        nextPage(); // Proceed to the next screen.
      },
      verificationFailed: (authException) {
        print(authException.message);
      },
      codeSent: (verificationId, [forceResendingToken]) {
        setState(() {
          phoneNumIn = true;
          this.verificationId = verificationId;
        });
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (context) => AlertDialog(
        //           title: const Text("Enter SMS Code"),
        //           content: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: <Widget>[
        //               TextField(
        //                 controller: phoneFieldController,
        //               ),
        //             ],
        //           ),
        //           actions: <Widget>[
        //             TextButton(
        //               onPressed: () {
        //                 setState(() {
        //                   smsCode = phoneFieldController.text.trim();
        //                   if (smsCode != null) {
        //                     _credential = PhoneAuthProvider.credential(
        //                         verificationId: verificationId,
        //                         smsCode: smsCode!);
        //                     this.verificationId = verificationId;
        //                     print(_credential);
        //                   }
        //                 });
        //               },
        //               child: const Text("Done"),
        //             )
        //           ],
        //         ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
        print(verificationId);
        print("Timout");
      },
    );
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
                "Please provide your phone number, it will be used for future login purposes.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 66, 66, 66)),
              )
            ],
          ),
        ),
        !phoneNumIn
            ? Form(
                key: _formKey,
                child: BottmFieldRequest(
                  buttonName: 'verify',
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
                  onNextPressed: validInputCheck,
                ),
              )
            : BottmFieldRequest(
                buttonName: 'confirm',
                controller: phoneFieldController,
                keyboardOn: isOnKeyBoard,
                hasError: false,
                keyboardType: TextInputType.number,
                onChanged: (val) {},
                hintText: '011235',
                errorText: errorText,
                validator: null,
                suffixWidget: const Icon(Icons.check),
                phoneNumberFocusNode: _phoneNumberFocusNode,
                onNextPressed: phoneAuth,
              ),
      ],
    );
  }

  /* -------------------- methods ------------------- */

  void phoneAuth() {
    nextPage();
    final smsCode = phoneFieldController.value.text;
    FirebaseAuth auth = FirebaseAuth.instance;
    _credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    auth.signInWithCredential(_credential).then((value) => nextPage());
    phoneNumIn = false;
    hasError = true;
    setState(() {});
  }

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
    final signin = PreApiService();
    final response = await signin.request(phoneNumber, ip + signUpURL);
    final message = await signin.reponseMessageCheck(response);

    if (message == 'success') {
      nextPage();
    }
    setState(() {
      errorText = message;
    });
  }

  // Navigate to the next screen.
  void nextPage() {
    Get.to(const EmailField());
  }

  // Check if the form input is valid and proceed accordingly.
  void validInputCheck() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        phoneNumber = "+82${phoneNumber.substring(1)}";
        nextPage();
        registerUser(phoneNumber, context);
      });
      //validationCheck(); // Uncomment when validation with the API is required.
    } else {
      setState(() {
        hasError = true;
      }); // Refresh the UI to show validation errors.
    }
  }
  /* -------------------- methods ------------------- */
}
