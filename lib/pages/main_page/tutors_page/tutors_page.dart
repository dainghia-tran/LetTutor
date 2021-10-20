import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/pages/private_message_page/private_message_page.dart';
import 'package:lettutor/pages/tutor_profile_page/tutor_profile_page.dart';
import 'package:lettutor/widgets/search_bar.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/tutor_card.dart';

const description1 =
    "Being a teacher is what I live for. Making a difference in a student's life, and seeing them progress and achieve their language goal, is the biggest pleasure in my life.";

class TutorsPage extends StatefulWidget {
  const TutorsPage({Key? key}) : super(key: key);

  @override
  _TutorsPageState createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> with AutomaticKeepAliveClientMixin {
  var countryCode = 'vn';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Tutors', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SearchBar(),
            Row(
              children: [
                IconButton(onPressed: (){
                  showCountryPicker(
                    context: context,
                    onSelect: (Country country) {
                      setState(() {
                        countryCode = country.countryCode.toLowerCase();
                      });
                    },
                  );
                }, icon: SvgPicture.asset('icons/flags/svg/$countryCode.svg', package: 'country_icons',)),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
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
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                    ),
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
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
