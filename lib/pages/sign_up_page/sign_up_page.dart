import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/pages/login_page/login_page.dart';
import 'package:lettutor/widgets/button/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      maxLines: 1,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
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
                      onPressed: () => {},
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
              )
            ]))
          ],
        ),
      ),
    );
  }
}
