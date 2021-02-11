import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:step_todo/screens/login_screen.dart';
import 'package:step_todo/screens/main_timeline_sreen.dart';
import 'package:step_todo/screens/registration_screen.dart';
import 'package:step_todo/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Goal Todo',
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        MainTimeLineScreen.id: (context) => MainTimeLineScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },
    );
  }
}
