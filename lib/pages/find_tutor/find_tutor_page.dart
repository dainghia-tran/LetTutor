import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/tutor_card.dart';

const description1 =
    "Being a teacher is what I live for. Making a difference in a student's life, and seeing them progress and achieve their language goal, is the biggest pleasure in my life.";

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
      body: SingleChildScrollView(
        child: Padding(
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
                    child: Tag(
                      text: 'All',
                      isActive: false,
                      onClick: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Tag(
                      text: 'English for kids',
                      isActive: false,
                      onClick: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Tag(
                        text: 'English for bussiness',
                        isActive: false,
                        onClick: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Tag(
                        text: 'Conversational',
                        isActive: false,
                        onClick: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child:
                        Tag(text: 'Starter', isActive: false, onClick: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Tag(text: 'Mover', isActive: false, onClick: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Tag(text: 'IELTS', isActive: true, onClick: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Tag(text: 'TOEFL', isActive: false, onClick: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: Tag(text: 'TOEIC', isActive: false, onClick: () {}),
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
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TutorCard(
                  isFavorite: true,
                  name: 'Tran Nghia',
                  stars: 4.5,
                  tags: ['English', 'Maths', 'Physics'],
                  description: description1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TutorCard(
                  isFavorite: false,
                  name: 'David Beckham',
                  stars: 4,
                  tags: ['English', 'Football'],
                  description: description1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: TutorCard(
                  isFavorite: true,
                  name: 'Issac Newton',
                  stars: 2.5,
                  tags: ['Maths', 'Physics', 'English'],
                  description: description1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
