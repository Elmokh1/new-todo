import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:new_todo/ui/login/login_screen.dart';


class Splash extends StatelessWidget {
  static const String routename = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Colors.white,
      splashIconSize: 800,
      splash: Image.asset("assets/images/logo_AgiHawk.png"),
      nextScreen: LoginScreen(),

    );
  }
}
