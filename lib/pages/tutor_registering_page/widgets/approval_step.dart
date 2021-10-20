import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/widgets/button/primary_button.dart';

class ApprovalStep extends StatefulWidget {
  const ApprovalStep({Key? key}) : super(key: key);

  @override
  _ApprovalStepState createState() => _ApprovalStepState();
}

class _ApprovalStepState extends State<ApprovalStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 16,
        ),
        SvgPicture.asset(
          'assets/become_tutor/approval_step.svg',
          height: 75,
          color: Colors.blue,
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'You have done all the steps',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const Text(
          "Please, wait for the operator's approval",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        PrimaryButton(
          isDisabled: false,
          onPressed: () => Navigator.pop(context, 'done'),
          text: 'Back home',
          width: 200,
        )
      ],
    );
  }
}
