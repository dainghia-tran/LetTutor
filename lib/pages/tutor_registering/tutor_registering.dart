import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lettutor/pages/tutor_registering/widgets/approval_step.dart';
import 'package:lettutor/pages/tutor_registering/widgets/profile_step.dart';
import 'package:lettutor/pages/tutor_registering/widgets/video_introduction_step.dart';
import 'package:lettutor/widgets/process_step.dart';

class TutorRegistering extends StatefulWidget {
  const TutorRegistering({Key? key}) : super(key: key);

  @override
  _TutorRegisteringState createState() => _TutorRegisteringState();
}

class _TutorRegisteringState extends State<TutorRegistering> {
  var currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop()),
        title: const Text(
          'Tutor registering',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ProcessStep(
                          order: 1,
                          content: 'Profile',
                          isCurrentStep: currentStep == 1,
                          isDone: currentStep > 1,
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ProcessStep(
                          order: 2,
                          content: 'Video introduction',
                          isCurrentStep: currentStep == 2,
                          isDone: currentStep > 2,
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ProcessStep(
                          order: 3,
                          content: 'Approval',
                          isCurrentStep: currentStep == 3,
                          isDone: currentStep > 3,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              if (currentStep == 1)
                ProfileStep(onPressNext: () {
                  setState(() {
                    currentStep++;
                  });
                })
              else if (currentStep == 2)
                VideoIntroductionStep(
                  onPressPrevious: () => setState(() => currentStep--),
                  onPressDone: () => setState(() => currentStep++),
                )
              else
                ApprovalStep()
            ],
          ),
        ),
      ),
    );
  }
}
