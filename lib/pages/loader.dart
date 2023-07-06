import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_manager/pages/home.dart';

class loader extends StatefulWidget {
  const loader({Key? key}) : super(key: key);

  @override
  State<loader> createState() => _loaderState();
}

class _loaderState extends State<loader> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Splash screen',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/Ace.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Text(
                    "Task manager",
                    style:const TextStyle(
                      fontSize: 26.0,
                      color: Colors.black,
                      fontFamily: 'Lato'
                    )
                ),
              ],
            ),
            nextScreen:  home(),
            splashTransition: SplashTransition.slideTransition,
            splashIconSize: 300,
            pageTransitionType: PageTransitionType.topToBottom,
            backgroundColor: Colors.white));
  }
  }
