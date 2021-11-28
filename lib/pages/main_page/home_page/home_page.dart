import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/pages/main_page/home_page/home_bloc.dart';
import 'package:lettutor/pages/private_message_page/private_message_page.dart';
import 'package:lettutor/pages/tutor_profile_page/tutor_profile_page.dart';
import 'package:lettutor/widgets/tutor_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.getTutors();
  }

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
              Center(
                child: StreamBuilder<List<Tutor>>(
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
                                  onClickBook: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TutorProfilePage())),
                                  onClickMessage: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              PrivateMessagePage(
                                                name: e.name,
                                              ))),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  stream: homeBloc.tutorsStream,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
