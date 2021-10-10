import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/widgets/tag.dart';

class FindTutorPage extends StatefulWidget {
  const FindTutorPage({Key? key}) : super(key: key);

  @override
  _FindTutorPageState createState() => _FindTutorPageState();
}

class _FindTutorPageState extends State<FindTutorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: SvgPicture.asset('assets/lettutor_logo.svg',
                semanticsLabel: 'LetTutor logo'),
          ),
          leadingWidth: 200),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find a tutor',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Tag(text: 'All', isActive: true, onClick: (){},),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Tag(text: 'English for kids', isActive: false, onClick: () {},),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Tag(text: 'English for bussiness', isActive: false, onClick: (){}),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Tag(text: 'Conversational', isActive: false, onClick: (){}),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Tag(text: 'Starter', isActive: false, onClick: (){}),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Tag(text: 'Mover', isActive: false, onClick: (){}),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Tag(text: 'IELTS', isActive: false, onClick: (){}),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Tag(text: 'TOEFL', isActive: false, onClick: (){}),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Tag(text: 'TOEIC', isActive: false, onClick: (){}),
                ),
              ],
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Recommended Tutors',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
