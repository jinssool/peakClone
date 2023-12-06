import 'package:dart/common/api/route_address.dart';
import 'package:dart/common/api/token_request.dart';
import 'package:dart/common/local_storage/const.dart';
import 'package:dart/home/home_screen.dart';
import 'package:dart/root_screen.dart';
import 'package:dart/user/common/main_layout.dart';
import 'package:dart/user/common/widget/top_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /* -------------------- init --------------------*/
  // Check if the user already has an access token
  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              throw Exception("unexpected situation : no data received ");
            } else if (snapshot.data == "success") {
              return const RootScreen();
            } else {
              return const HomeScreen();
            }
          }

          return MainLayout.purple(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Image.asset(
                  'assets/img/mascot/moving_mascot.gif',
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const Expanded(child: _BottomCircleProgressBar()),
              const Expanded(
                  child: SingleChildScrollView(child: _MiddleText())),
            ],
          );
        });
  }

  /*========================== method ==========================*/
  Future<String?> getToken() async {
    // Read the token from user local storage

    final accessToken = await storage.read(key: accessTokenKeyLS);
    print("=============$accessToken==========");
    if (accessToken != null) {
      return login(accessToken); // User has a token, check if it is valid.
    } else {
      nextPage(const HomeScreen()); // User doesn't have a token
    }
    return null;
  }

  // Go to the next page
  void nextPage(Widget page) {
    Get.to(() => page);
  }

  // Check whether the refreshToken is valid or not
  Future<String?> login(String accessToken) async {
    final login = ApiService();

    final response = await login.splahsWithToken(
      accessToken,
      splashURL,
    );
    final message = await login.tokenReponseCheck(response);
    print(message);
    return message;
  }
  /*========================== method ==========================*/
}

class _BottomCircleProgressBar extends StatelessWidget {
  const _BottomCircleProgressBar();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 5,
          ),
        ),
      ],
    );
  }
}

class _MiddleText extends StatelessWidget {
  const _MiddleText();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'PeakTew',
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
      ],
    );
  }
}
