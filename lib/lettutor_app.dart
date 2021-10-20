import 'package:flutter/material.dart';
import 'package:lettutor/pages/login_page/login_page.dart';

class LetTutorApp extends StatelessWidget {
  const LetTutorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter'),
      home: const LoginPage(),
    );
  }
}
