import 'package:attendance_button/login/sign_in_with_user_id.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '출퇴근 시간체크',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPageWithUserId(),
    );
  }
}