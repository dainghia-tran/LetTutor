import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/pages/main_page/tutors_page/tutors_page_bloc.dart';
import 'package:lettutor/pages/tutor_profile_page/tutor_profile_page.dart';
import 'package:lettutor/widgets/search_bar.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/tutor_card.dart';

const tags = [
  'All',
  'English for kids',
  'English for bussiness',
  'Conversational',
  'TOEIC',
  'TOEFL',
  'IELTS',
  'Mover',
  'Starter'
];

class TutorsPage extends StatefulWidget {
  const TutorsPage({Key? key}) : super(key: key);

  @override
  _TutorsPageState createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  var countryCode = 'vn';
  final tutorsBloc = TutorsBloc();
  var tagIndex = 0;

  @override
  void initState() {
    super.initState();
    tutorsBloc.getTutors();
  }

  @override
  Widget build(BuildContext context) {
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
            SearchBar(
              onSearch: tutorsBloc.searchTutors,
            ),
            Row(
              children: [
                CountryCodePicker(
                  onChanged: (country) {
                    setState(() {
                      countryCode = country.code?.toLowerCase() ?? 'VN';
                      tagIndex = -1;
                    });
                    tutorsBloc.filterTutorsByCountry(
                        country.code?.toLowerCase() ?? 'VN');
                  },
                  initialSelection: 'VN',
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _buildTagsList(),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: StreamBuilder<List?>(
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: TutorCard(
                                  tutor: e,
                                  onClickCard: () async {
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TutorProfilePage(
                                          tutorId: e.userId ?? e.user!.id,
                                        ),
                                      ),
                                    );
                                    tutorsBloc.getTutors();
                                  },
                                  needReload: () => tutorsBloc.getTutors(),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(top: 200),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                  stream: tutorsBloc.tutorsStream,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildTagsList() {
    final List<Widget> children = [];
    for (var i = 0; i < tags.length; i++) {
      children.add(Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        child: Tag(
            text: tags[i],
            isActive: tagIndex == i,
            onClick: () {
              setState(() {
                tagIndex = i;
              });
              tutorsBloc.filterTutorsByTag(tags[i]);
            }),
      ));
    }
    return children;
  }
}
