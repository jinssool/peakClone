import 'package:dart/common/api/firebase_api.dart';
import 'package:dart/common/api/local_notification_service.dart';
import 'package:dart/profiles/constants/user.dart';
import 'package:dart/home/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Initialize and open the Hive userBox.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());
  await Hive.openBox<UserData>('loggedUser');
  await FirebaseService().initNotifications();
  await LocalNotificationService.initialize();

  runApp(const App());
}

// The main application widget.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
