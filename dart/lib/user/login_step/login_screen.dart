import 'package:dart/common/api/firebase_api.dart';
import 'package:dart/common/local_storage/const.dart';

import 'package:dart/profiles/constants/boxes.dart';
import 'package:dart/profiles/constants/user.dart';
import 'package:dart/root_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dart/common/api/request.dart';
import 'package:get/get.dart' as prefix;
import '../common/custom_textform.dart';
import '../../common/api/route_address.dart';
import '../common/const/color.dart';
import '../common/main_layout.dart';
import '../../user/common/regular_expression.dart';
import '../common/widget/top_image.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _phoneNumFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyId = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  String? errorText;
  String id = '';
  String password = '';
  bool hasError = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _phoneNumFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    bool isOnKeyBoard = MediaQuery.of(context).viewInsets.bottom != 0;
    return MainLayout.purple(
      children: [
        const Expanded(child: TopImage()),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: _MiddleTextField(
              phoneNumberFocus: _phoneNumFocusNode,
              passwordFocus: _passwordFocusNode,
              phoneNumberValidator: (value) => value?.validatePhoneNumber(
                  _phoneNumFocusNode, value), // Validate ID.
              passwordValidator: (value) =>
                  value?.validatePassword(_passwordFocusNode, value),
              idKey: _formKeyId,
              passwordKey: _formKeyPassword,
              hasError: hasError,
              onIdChanged: onIdChanged,
              errorText: errorText,
              onPasswordChanged: onPasswordChanged,
            ),
          ),
        ),
        SizedBox(
          height: isOnKeyBoard ? 0.0 : 20,
        ),
        _BottomLogin(
          onLoginPressed: validInputCheck,
        ),
        SizedBox(
          height: isOnKeyBoard ? 10.0 : 50,
        ),
      ],
    );
  }

  void getPersonalInfo(Response<dynamic>? response) async {
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
      isUserPreviouslyCached != null ? null : box1.put(phoneNumber, loggedUser);

      print(
          '=================from loginscreen: ${box1.get(phoneNumber)?.name}');
    }
  }

  /* -------------------- methods ------------------- */

  // Perform the login request.
  void login() async {
    final login = PreApiService();
    final fcmToken = await FirebaseService().getToken();
    final response = await login.request(
      '$id:$password',
      logInURL,
      fcmToken: fcmToken,
    );
    final message = await login.reponseMessageCheck(response);
    print("message : ${message}");
    if (message == 'success') {
      //save user's Personal data from Server
      getPersonalInfo(response);
      // Update tokens in local storage.
      print("==============================>data:${response!.data}");
      final refreshToken = response.data['refreshToken'];
      final accessToken = response.data['accessToken'];
      await storage.delete(key: accessTokenKeyLS);
      await storage.delete(key: refreshTokenKeyLS);
      await storage.write(key: accessTokenKeyLS, value: accessToken);
      await storage.write(key: refreshTokenKeyLS, value: refreshToken);

      nextPage();
    } else {
      setState(() {
        errorText = message;
      });
    }
  }

  void nextPage() {
    prefix.Get.offAll(const RootScreen());
  }

  // Validate input and proceed with login.
  void validInputCheck() {
    if (_formKeyId.currentState!.validate() &&
        _formKeyPassword.currentState!.validate()) {
      login(); // Perform login.
    } else {
      setState(() {}); // Refresh the UI to show validation errors.
    }
  }

  // Called when the ID input value changes.
  void onIdChanged(String value) {
    setState(() {
      if (_formKeyId.currentState!.validate()) {
        hasError = false;
        errorText = null;
      } else {
        hasError = true;
      }

      id = value;

      // Scroll to top when ID input is focused
      if (_phoneNumFocusNode.hasFocus) {
        scrollToTop();
      }
    });
  }

  // Called when the password input value changes.
  void onPasswordChanged(String value) {
    setState(() {
      if (_formKeyPassword.currentState!.validate()) {
        hasError = false;
        errorText = null;
      } else {
        hasError = true;
      }

      password = value;

      // Scroll to bottom when password input is focused
      if (_passwordFocusNode.hasFocus) {
        scrollToBottom();
      }
    });
  }

/* test for merge*/
  // Scroll to the top of the screen
  void scrollToTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  // Scroll to the bottom of the screen
  void scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

/* -------------------- methods ------------------- */
}

class _MiddleTextField extends StatelessWidget {
  final ValueChanged<String> onIdChanged;
  final String? errorText;
  final ValueChanged<String> onPasswordChanged;
  final FocusNode phoneNumberFocus;
  final FocusNode passwordFocus;
  final bool hasError;
  final GlobalKey idKey;
  final GlobalKey passwordKey;
  final String? Function(String?)? passwordValidator;
  final String? Function(String?)? phoneNumberValidator;
  const _MiddleTextField({
    required this.phoneNumberValidator,
    required this.passwordValidator,
    required this.idKey,
    required this.phoneNumberFocus,
    required this.passwordFocus,
    required this.passwordKey,
    required this.hasError,
    required this.errorText,
    required this.onPasswordChanged,
    required this.onIdChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: idKey,
          child: CustomTextFormField.log(
            hasError: hasError,
            errorText: errorText,
            keyboardType: TextInputType.number,
            onChanged: onIdChanged,
            hintText: 'ID', // Placeholder text for ID input.
            autofocus: true,
            focusNode: phoneNumberFocus,
            validator: phoneNumberValidator,
          ),
        ),
        SizedBox(
          height: hasError ? 0 : 20.0,
        ),
        Form(
          key: passwordKey,
          child: CustomTextFormField.log(
            hasError: hasError,
            errorText: errorText,
            onChanged: onPasswordChanged,
            hintText: 'Password', // Placeholder text for password input.
            obscureText: true,
            focusNode: passwordFocus,
            validator: passwordValidator,
          ),
        )
      ],
    );
  }
}

class _BottomLogin extends StatelessWidget {
  final VoidCallback onLoginPressed;

  const _BottomLogin({required this.onLoginPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          MediaQuery.of(context).size.width * 1 / 3,
          MediaQuery.of(context).size.height * 1 / 15,
        ),
        backgroundColor: nextButtonColor,
        foregroundColor: const Color.fromARGB(185, 46, 45, 45),
        textStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      onPressed: onLoginPressed, // Called when the login button is pressed.
      child: const Text('LOG  IN'),
    );
  }
}
