import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/pages/private_message_page/private_message_page.dart';
import 'package:lettutor/pages/tutor_profile_page/tutor_profile_page.dart';
import 'package:lettutor/widgets/tutor_card.dart';

const description1 =
    "Being a teacher is what I live for. Making a difference in a student's life, and seeing them progress and achieve their language goal, is the biggest pleasure in my life.";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.indigo),
                child: const Center(
                    child: Text(
                  'Total lesson time is 12 hours 55 minutes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recommended Tutors',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'See all ᐳ',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TutorCard(
                  onClickBook: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const TutorProfilePage())),
                  onClickMessage: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const PrivateMessagePage(name: 'Tran Nghia',))),
                  isFavorite: true,
                  name: 'Tran Nghia',
                  stars: 4.5,
                  tags: const ['English', 'Maths', 'Physics'],
                  description: description1,
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TutorCard(
                  onClickBook: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const TutorProfilePage())),
                  onClickMessage: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const PrivateMessagePage(name: 'David Beckham',))),
                  isFavorite: false,
                  name: 'David Beckham',
                  stars: 4,
                  tags: const ['English', 'Football'],
                  description: description1,
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TutorCard(
                  onClickBook: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const TutorProfilePage())),
                  onClickMessage: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const PrivateMessagePage(name: 'Issac Newton',))),
                  isFavorite: true,
                  name: 'Issac Newton',
                  stars: 2.5,
                  tags: const ['Maths', 'Physics', 'English'],
                  description: description1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
