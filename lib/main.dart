import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_todo/ui/login/login_screen.dart';
import 'package:new_todo/ui/register/register_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
              headline4: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
          ),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true
          ),
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFDFECDB),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.transparent,
              elevation: 0
          )
      ),
      initialRoute: RegisterScreen.routeName,
      routes: {
        RegisterScreen.routeName :(context) =>RegisterScreen(),
        LoginScreen.routeName :(context) =>LoginScreen(),
      },
    );
  }
}


