import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/pages/pushnotifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async{
print(message.notification?.title);
print(message.notification?.body);

}

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await  _firebaseMessaging.requestPermission();
    final fcmToken= await _firebaseMessaging.getToken();
    print(fcmToken);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}