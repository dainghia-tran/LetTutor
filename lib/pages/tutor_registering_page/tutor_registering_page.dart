import 'package:flutter/material.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/pages/tutor_registering_page/tutor_regstering_provider.dart';
import 'package:lettutor/pages/tutor_registering_page/widgets/approval_step.dart';
import 'package:lettutor/pages/tutor_registering_page/widgets/profile_step.dart';
import 'package:lettutor/pages/tutor_registering_page/widgets/video_introduction_step.dart';
import 'package:lettutor/widgets/process_step.dart';
import 'package:provider/provider.dart';

class TutorRegisteringPage extends StatefulWidget {
  const TutorRegisteringPage({Key? key}) : super(key: key);

  @override
  _TutorRegisteringPageState createState() => _TutorRegisteringPageState();
}

class _TutorRegisteringPageState extends State<TutorRegisteringPage> {
  var currentStep = 1;

  @override
  void initState() {
    super.initState();
    final user = AppProvider.auth?.user ?? User();
    if (user.tutorInfo != null) {
      setState(() {
        currentStep = 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TutorRegisteringProvider(),
      child: Scaffold(
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
      ),
    );
  }
}
