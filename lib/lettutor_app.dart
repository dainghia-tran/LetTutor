import 'package:flutter/material.dart';
import 'package:lettutor/pages/main_page/main_page.dart';

class LetTutorApp extends StatelessWidget {
  const LetTutorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter'),
      home: const MainPage(),
    );
  }
}
