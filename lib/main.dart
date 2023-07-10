import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:smartdine_waiter/core/utils/app_theme.dart';
import 'package:smartdine_waiter/splash_screen.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp(options: FirebaseOptions(
       apiKey: "AIzaSyCPqcDPG0-bVgyUp-Rud5XEqR3Of-p_zG4",
       appId: "1:118404131771:android:16a03aa035986910a5729e",
       messagingSenderId: "118404131771",
       projectId: "smartdine-878e8",
       storageBucket: 'smartdine-878e8.appspot.com'));
  await di.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartDine waiter',
      debugShowCheckedModeBanner: false,
      theme: appPrimaryTheme(),
      home: SplashScreen(),
    );
  }
}
