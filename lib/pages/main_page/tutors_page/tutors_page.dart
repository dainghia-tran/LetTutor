import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/pages/main_page/tutors_page/tutors_page_provider.dart';
import 'package:lettutor/pages/tutor_profile_page/tutor_profile_page.dart';
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';
import 'package:lettutor/widgets/search_bar.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/tutor_card.dart';
import 'package:provider/provider.dart';

const tags = [
  'All',
  'English for kids',
  'Bussiness English',
  'Conversational English',
  'TOEIC',
  'TOEFL',
  'IELTS',
  'KET',
  'PET',
  'Movers',
  'Flyers',
  'Starters'
];

class TutorsPage extends StatefulWidget {
  const TutorsPage({Key? key}) : super(key: key);

  @override
  _TutorsPageState createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  var countryCode = 'vn';
  final _tutorsProvider = TutorsPageProvider();
  var tagIndex = 0;

  @override
  void initState() {
    super.initState();
    _tutorsProvider.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _tutorsProvider,
      child: Scaffold(
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
                onSearch: _tutorsProvider.searchTutors,
              ),
              Row(
                children: [
                  CountryCodePicker(
                    onChanged: (country) {
                      setState(() {
                        countryCode = country.code?.toLowerCase() ?? 'VN';
                        tagIndex = -1;
                      });
                      _tutorsProvider.filterTutorsByCountry(
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
                          children: [
                            Column(
                              children: snapshot.data!
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: TutorCard(
                                        tutor: e,
                                        onClickCard: () async {
                                          await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TutorProfilePage(
                                                tutorId: e.userId ?? e.user!.id,
                                              ),
                                            ),
                                          );
                                          _tutorsProvider.getTutors(true);
                                        },
                                        needReload: () =>
                                            _tutorsProvider.getTutors(true),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            Container(
                              height: 50,
                              child: Consumer<TutorsPageProvider>(
                                  builder: (_, prov, __) {
                                if (prov.hasLoadMore) {
                                  return SecondaryButton(
                                    isDisabled: false,
                                    onPressed: () {
                                      prov.getTutors(false);
                                    },
                                    text: 'Load more',
                                  );
                                }
                                return Container();
                              }),
                            )
                          ],
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
                    stream: _tutorsProvider.tutorsStream,
                  ),
                ),
              ),
            ],
          ),
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
              _tutorsProvider.filterTutorsByTag(tags[i]);
            }),
      ));
    }
    return children;
  }
}
