import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_todo/admin_screen/admin_screen.dart';
import 'package:new_todo/map/map.dart';
import 'package:new_todo/provider/Auth_provider.dart';
import 'package:new_todo/ui/HomeScreen/home_screen.dart';
import 'package:new_todo/ui/Splash/splash_screen.dart';
import 'package:new_todo/ui/login/login_screen.dart';
import 'package:new_todo/ui/register/register_screen.dart';
import 'package:provider/provider.dart';

import 'admin_screen/user_information.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (buildcontext) => appProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
              headline4: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true),
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFDFECDB),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.transparent, elevation: 0)),
      initialRoute: Splash.routename,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        Splash.routename: (context) => Splash(),
        AdminScreen.routeName: (context) => AdminScreen(),
        MapTRACK.routeName: (context) => MapTRACK(),
      },
    );
  }
}
