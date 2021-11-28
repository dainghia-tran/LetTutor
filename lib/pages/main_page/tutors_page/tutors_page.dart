import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/widgets/search_bar.dart';
import 'package:lettutor/widgets/tag.dart';

const description1 =
    "Being a teacher is what I live for. Making a difference in a student's life, and seeing them progress and achieve their language goal, is the biggest pleasure in my life.";

class TutorsPage extends StatefulWidget {
  const TutorsPage({Key? key}) : super(key: key);

  @override
  _TutorsPageState createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage>
    with AutomaticKeepAliveClientMixin {
  var countryCode = 'vn';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Tutors',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SearchBar(),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          setState(() {
                            countryCode = country.countryCode.toLowerCase();
                          });
                        },
                      );
                    },
                    icon: SvgPicture.asset(
                      'icons/flags/svg/$countryCode.svg',
                      package: 'country_icons',
                    )),
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
                          child: Tag(
                              text: 'Starter', isActive: false, onClick: () {}),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: Tag(
                              text: 'Mover', isActive: false, onClick: () {}),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: Tag(
                              text: 'IELTS', isActive: true, onClick: () {}),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: Tag(
                              text: 'TOEFL', isActive: false, onClick: () {}),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: Tag(
                              text: 'TOEIC', isActive: false, onClick: () {}),
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
                  children: [],
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
