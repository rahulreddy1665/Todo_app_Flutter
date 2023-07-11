import 'package:flutter/material.dart';
import 'package:task_manager/api/firebase_api.dart';
import 'package:task_manager/api/notification_service.dart';
import 'package:task_manager/pages/edit.dart';
import 'package:task_manager/pages/home.dart';
import 'package:task_manager/pages/loader.dart';
import 'package:task_manager/pages/pushnotifications.dart';
import 'package:task_manager/pages/taskcreation.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initializeNotification();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    const secondaryColor = Color(0xff6D28D9);
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Awesome Notification Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        shadowColor: secondaryColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const loader(),
        '/home': (context) => const home(),
        '/taskcreation': (context) => const taskcreation(),
        '/edit': (context) => const EditTaskPage(),
        '/notifications': (context) => const PushNoitifications(),
      },
    );
  }
}
