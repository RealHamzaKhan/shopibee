import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/views/splash_screen/splash_screen.dart';

import 'consts/strings.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
            elevation: 0.0,
            actionsIconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.transparent),
          fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
