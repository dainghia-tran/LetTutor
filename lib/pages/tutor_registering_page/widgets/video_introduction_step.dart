import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';
import 'package:lettutor/widgets/divider_text.dart';
import 'package:lettutor/widgets/expandable_text.dart';

const setupContent = 'Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, expertise and personality. Students can be nervous to speak with a foreigner, so it really helps to have a friendly video that introduces yourself and invites students to call you.';

class VideoIntroductionStep extends StatefulWidget {
  const VideoIntroductionStep({Key? key, required this.onPressPrevious, required this.onPressDone}) : super(key: key);
  final onPressPrevious;
  final onPressDone;

  @override
  _VideoIntroductionStepState createState() => _VideoIntroductionStepState();
}

class _VideoIntroductionStepState extends State<VideoIntroductionStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/become_tutor/video_introduction_step.svg',
              height: 80,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Set up your tutor profile',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ExpandableText(
                    content: setupContent,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16,),
        const DividerText(text: 'Introduction video'),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: const Color(0xFFE6F7FF),
              border: Border.all(width: 1, color: Colors.blue),
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('A few helpful tips', style: TextStyle(fontSize: 12),),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('1. Find a clean and quiet space', style: TextStyle(fontSize: 12),),
                  Text('2. Smile and look at the camera', style: TextStyle(fontSize: 12),),
                  Text('3. Dress smart', style: TextStyle(fontSize: 12),),
                  Text('4. Speak for 1-3 minutes', style: TextStyle(fontSize: 12),),
                  Text('5. Brand yourself and have fun!', style: TextStyle(fontSize: 12),),
                ],
              ),)
            ],
          )
        ),
        const SizedBox(height: 16,),
        Center(child: SecondaryButton(isDisabled: false, onPressed: (){}, text: 'Choose video', width: 150,)),
        const SizedBox(height: 32,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SecondaryButton(isDisabled: false, onPressed: widget.onPressPrevious, text: 'Previous', width: 100,),
            PrimaryButton(isDisabled: false, onPressed: widget.onPressDone, text: 'Done', width: 100,),
          ],
        )
      ],
    );
  }
}
