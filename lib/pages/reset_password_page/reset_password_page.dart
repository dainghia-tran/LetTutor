import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/widgets/button/primary_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
                maxLines: 1,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: PrimaryButton(
                isDisabled: false,
                onPressed: () => {},
                text: 'Send reset link',
                width: 150,
              ),
            )
          ],
        ),
      ),
    );
  }
}
