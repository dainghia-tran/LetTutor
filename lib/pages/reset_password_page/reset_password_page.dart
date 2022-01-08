import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/pages/login_page/login_page.dart';
import 'package:lettutor/widgets/button/primary_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var _resetPassKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Container(
          width: 180,
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: SvgPicture.asset('assets/lettutor_logo.svg',
              semanticsLabel: 'LetTutor logo'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _resetPassKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Reset Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const Text(
                'Please enter your email address to search for your account',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: emailController,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    } else if (!EmailValidator.validate(value)) {
                      return "Not a valid email";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: PrimaryButton(
                  isDisabled: false,
                  onPressed: () async {
                    if (_resetPassKey.currentState!.validate()) {
                      bool result = await sendReset();
                      if (result == true) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    }
                  },
                  text: 'Send reset link',
                  width: 150,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> sendReset() async {
    try {
      var body = {
        'email': emailController.text,
      };
      var dio = Http().client;
      await dio.post(
        'user/forgotPassword',
        data: body,
      );
      const snackbar =
          SnackBar(content: Text('Reset link sent to your email address'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return true;
    } catch (e) {
      final snackbar = SnackBar(
          content: Text((e as DioError).response?.data['message'] ??
              'Something went wrong'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return false;
    }
  }
}
