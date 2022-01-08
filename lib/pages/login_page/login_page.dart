import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/auth.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/pages/login_page/validator.dart' as validator;
import 'package:lettutor/pages/main_page/main_page.dart';
import 'package:lettutor/pages/reset_password_page/reset_password_page.dart';
import 'package:lettutor/pages/sign_up_page/sign_up_page.dart';
import 'package:lettutor/widgets/button/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: SvgPicture.asset('assets/lettutor_logo.svg',
                    semanticsLabel: 'LetTutor logo'),
              ),
              leadingWidth: 200,
              floating: false,
              pinned: true,
              snap: false,
              expandedHeight: 450,
              automaticallyImplyLeading: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/login/appbar.png',
                      height: 300,
                    ),
                    const Text('Say hello to your English tutors',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    const Text(
                        'Become fluent faster through one on one video chat lessons tailored to your goals.',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
              )),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) => validator.emailValidator(value),
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        validator: (value) =>
                            validator.passwordValidator(value),
                        maxLines: 1,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Not a member yet? ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            child: const Text('Sign up',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                            onTap: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            )),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        isDisabled: false,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));
                          }
                        },
                        text: 'Log in',
                      ),
                      const SizedBox(height: 16),
                      const Text('Or continue with'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Boxicons.bxl_facebook_circle),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Boxicons.bxl_google),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Forgot password? ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPasswordPage())),
                              child: const Text(
                                'Recover password',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }

  Future<Auth?> login(String email, String password) async {
    try {
      var body = {
        'email': email,
        'password': password,
      };
      var dio = Http().client;
      var res = await dio.post(
        'auth/login',
        data: body,
      );
      var auth = Auth.fromJson(res.data);
      inspect(auth);
      var accessToken = auth.tokens!.access!.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var resInfo = await dio.get("user/info");
      auth.user = User.fromJson(resInfo.data["user"]);
      inspect(auth);
      return auth;
    } catch (e) {
      inspect(e);
      return null;
    }
  }
}
