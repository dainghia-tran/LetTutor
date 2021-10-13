import 'package:flutter/material.dart';
import 'package:lettutor/pages/find_tutor/find_tutor_page.dart';
import 'package:lettutor/pages/login/login_page.dart';
import 'package:lettutor/pages/reset_password/reset_password_page.dart';
import 'package:lettutor/pages/sign_up/sign_up_page.dart';
import 'package:lettutor/pages/tutor_profile_page/tutor_profile_page.dart';

class LetTutorApp extends StatelessWidget {
  const LetTutorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Inter'),
      home: const TutorProfilePage(),
    );
  }
}
