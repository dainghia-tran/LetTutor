import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/pages/login_page/login_page.dart';
import 'package:lettutor/widgets/button/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _showPassword = false;
  final _signUpFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
              Form(
                key: _signUpFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 24),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 1),
                            ),
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
                      Container(
                        padding: EdgeInsets.only(bottom: 24),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 1),
                            ),
                            labelText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          obscureText: !_showPassword,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            } else {
                              RegExp regExp = RegExp(
                                  r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
                              if (!regExp.hasMatch(value)) {
                                return "Password must contain at least 8 characters, one letter and one number";
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 24),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 1),
                            ),
                            labelText: 'Confirm Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          obscureText: !_showPassword,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            } else if (value != passwordController.text) {
                              return "Input not match with current password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage())),
                        child: RichText(
                          text: const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: 'Log in',
                                    style: TextStyle(color: Colors.blue))
                              ]),
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        isDisabled: false,
                        onPressed: () async {
                          if (_signUpFormKey.currentState!.validate()) {
                            bool result = await signUp();
                            if (result == true) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            }
                          }
                        },
                        text: 'Sign Up',
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

  Future<bool> signUp() async {
    try {
      var body = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      var dio = Http().client;
      await dio.post(
        'auth/register',
        data: body,
      );
      const snackbar =
          SnackBar(content: Text('Verify email sent to your email address'));
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
