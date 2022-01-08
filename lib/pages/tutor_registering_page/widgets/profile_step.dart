import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:lettutor/widgets/divider_text.dart';
import 'package:lettutor/widgets/expandable_text.dart';

const setupContent =
    "Your tutor profile is your chance to market yourself to students on Tutoring. You can make edits later on your profile settings page."
    "New students may browse tutor profiles to find a tutor that fits their learning goals and personality. Returning students may use the tutor profiles to find tutors they've had great experiences with already.";

enum Level { beginer, intermediate, advanced }

class ProfileStep extends StatefulWidget {
  const ProfileStep({Key? key, required this.onPressNext}) : super(key: key);
  final onPressNext;

  @override
  _ProfileStepState createState() => _ProfileStepState();
}

class _ProfileStepState extends State<ProfileStep> {
  Level? level = Level.beginer;
  var countryName = 'Vietnam';
  DateTime selectedDate = DateTime.now();
  Map<String, bool> specialities = {
    'English for kids': false,
    'English for business': false,
    'Conversational': false,
    'STARTERS': false,
    'MOVERS': false,
    'FLYERS': false,
    'KET': false,
    'PET': false,
    'IELTS': false,
    'TOEFL': false,
    'TOEIC': false,
  };

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/become_tutor/profile_step.png',
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
                    'Introduce yourself',
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
        const DividerText(text: 'Basic info'),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: DottedBorder(
            dashPattern: const [5, 1],
            color: Colors.black,
            strokeWidth: 1,
            child: Container(
              height: 200,
              width: 200,
              color: Colors.grey.shade200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Upload avatar here...',
                    style: TextStyle(fontSize: 12, color: Colors.black38),
                  ),
                  Text(
                    'Tap to upload',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: const Color(0xFFE6F7FF),
              border: Border.all(width: 1, color: Colors.blue),
              borderRadius: BorderRadius.circular(4)),
          child: const Center(
              child: Text(
            'Please upload a professional photo. See guidelines',
            style: TextStyle(fontSize: 12),
          )),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Phone number',
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Phone number',
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "I'm from",
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(8)),
            height: 48,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  countryName,
                  textAlign: TextAlign.left,
                )),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text('Date of Birth'),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(8)),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedDate.toString().split(' ')[0]),
              IconButton(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const DividerText(text: 'CV'),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Students will view this information on your profile to decide if you're a good fit for them.",
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: const Color(0xFFE6F7FF),
              border: Border.all(width: 1, color: Colors.blue),
              borderRadius: BorderRadius.circular(4)),
          child: const Center(
              child: Text(
            'In order to protect your privacy, please do not share your personal information (email, phone number, social email, skype, etc) in your profile.',
            style: TextStyle(fontSize: 12),
          )),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Interests',
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText:
                "Interests, hobbies, memorable life experiences, or anything else you'd like to share!",
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Education',
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText:
                'Example: "Bachelor of Arts in English from Cambly University; Certified yoga instructor, Second Language Acquisition and Teaching  (SLAT) certificate from Cambly University"',
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Experience',
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Current or previous Profession',
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const DividerText(text: 'Language I speak'),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Language',
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          maxLines: 2,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const DividerText(text: 'Who I teach'),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: const Color(0xFFE6F7FF),
              border: Border.all(width: 1, color: Colors.blue),
              borderRadius: BorderRadius.circular(4)),
          child: const Center(
              child: Text(
            'This is the first thing students will see when looking for tutors.',
            style: TextStyle(fontSize: 12),
          )),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Introduction',
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText:
                'Example: "I was a doctor for 35 years and can help you practice business or medical English. I also enjoy teaching beginners as I am very patient and always speak slowly and clearly. "',
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'I am best at teaching students who are',
        ),
        const SizedBox(
          height: 8,
        ),
        ListTile(
          title: const Text('Beginer'),
          leading: Radio<Level>(
            value: Level.beginer,
            groupValue: level,
            onChanged: (value) => setState(() {
              level = value;
            }),
          ),
        ),
        ListTile(
          title: const Text('Intermediate'),
          leading: Radio<Level>(
            value: Level.intermediate,
            groupValue: level,
            onChanged: (value) => setState(() {
              level = value;
            }),
          ),
        ),
        ListTile(
          title: const Text('Advanced'),
          leading: Radio<Level>(
            value: Level.advanced,
            groupValue: level,
            onChanged: (value) => setState(() {
              level = value;
            }),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'My specialities are',
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          children: specialities.keys
              .map((e) => CheckboxListTile(
                    title: Text(e),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool? value) {
                      setState(() {
                        specialities[e] = value ?? false;
                      });
                    },
                    value: specialities[e],
                  ))
              .toList(),
        ),
        PrimaryButton(
            isDisabled: false, onPressed: widget.onPressNext, text: 'Save')
      ],
    );
  }
}
