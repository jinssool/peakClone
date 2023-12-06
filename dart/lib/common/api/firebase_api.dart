import 'dart:async';
import 'package:dart/common/api/local_notification_service.dart';
import 'package:dart/common/api/token_request.dart';
import 'package:dart/common/local_storage/const.dart';
import 'package:dart/explore_screen/explore_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

printLog(RemoteMessage message) {
  print("onBackgroundMessage");
  print('Title: ${message.notification!.title}');
  print('Body: ${message.notification!.body}');
  print('Payload: ${message.data.toString()}');
}

//----- when user receives push notification in background this methods is implemented--//
//----- backgroundHandler function should be top-level function -----//
Future _backgroundHandler(RemoteMessage message) async {
  printLog(message);
  LocalNotificationService.createanddisplaynotification(message);
}

class FirebaseService {
  //---- When app turns on, this method is implemented ----//
  Future<void> _initialMessageHandler(RemoteMessage? message) async {
    print("FirebaseMessaging.instance.getInitialMessage");
    if (message != null) {
      printLog(message);
    }
  }

  //---- When app is in foreground, this method is implemented ----//
  Future _onMessageHandler(RemoteMessage message) async {
    print('FirebaseMessaging.onMessage.listen');
    if (message.notification != null) {
      printLog(message);
      LocalNotificationService.createanddisplaynotification(message);
    }
  }

  //---- When app is background and user clicks push notifications, this method is implemented ----//
  Future _onMessageOpenApp(RemoteMessage message) async {
    print('FirebaseMessaging.onMessageOpenedApp.listen');
    if (message.notification != null) {
      printLog(message);
      //if(storage.read(key: accessTokenKeyLS)!= null){
      //Get.to(()=> LoginScreen());
      //}
      Get.to(() => const ExploreScreen());
    }
  }

  Future<String?> getToken() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    final fcmToken = await firebaseMessaging.getToken();
    print('Token: $fcmToken');
    return fcmToken;
  }

  //logout 시 fcmToken 삭제 요청 메소드 임의로 구현
  Future<void> deleteFcmToken() async {
    final deleteFcmToken = ApiService();
    final accessToken = await storage.read(key: accessTokenKeyLS);
    if (accessToken != null) {
      final response = await deleteFcmToken.requestWithToken( accessToken, '삭제 url미정');
      if (response?.statusCode == 200){
        print('succeed to delete fcmToken');
      } else {
        print('failed to delete fcmToken');
      }
    }
  }


  Future<void> initNotifications() async {
    await Firebase.initializeApp();
    final firebaseMessaging = FirebaseMessaging.instance;

    // fcmToken 갱신시 db에 있는 fcmToken 갱신 요청
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      final fcmToken = await FirebaseService().getToken();
      final refreshFcmToken = ApiService();
      final accessToken = await storage.read(key: accessTokenKeyLS);
      if(accessToken != null ){
        final response = await refreshFcmToken.postWithToken(
          accessToken: accessToken, toUrl: '갱신 url미정', data: fcmToken,
        );
        if (response?.statusCode == 200){
          print('succeed to refresh fcmToken');
        } else {
          print('failed to refresh fcmToken');
        }
      }
    }).onError((err) {
      print('Error getting new FcmToken');
    });


    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    firebaseMessaging.getInitialMessage().then(_initialMessageHandler);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    // iOS foreground notification 권한
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // ios,macOS 및 웹의 경우 fcm 페이로드를 기기에서 받으려면 먼저 사용자 권한을 요청해야함
  }
}
