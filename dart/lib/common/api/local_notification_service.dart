import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:dart/explore_screen/explore_screen.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        print('onDidReceiveNotificationResponse : ${details.payload}');
        //ModeControllerWithGetX controller = Get.put(ModeControllerWithGetX());
        //controller.changeToNormal();

        Get.to(() => const ExploreScreen());
      },
    );
  }

// 푸시 알림 보내는 함수
  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id =
          DateTime.now().millisecondsSinceEpoch ~/ 1000; // 현재시간을 초 단위로 표시한 값
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "peaktewNotificationapp",
          "peaktewNotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
          icon: "@mipmap/ic_launcher",
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );

    } on Exception catch (e) {
      print(e);
    }
  }
}
