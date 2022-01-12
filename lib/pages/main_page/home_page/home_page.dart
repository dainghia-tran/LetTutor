import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/pages/lesson_room_page/lesson_room_page.dart';
import 'package:lettutor/pages/main_page/home_page/home_bloc.dart';
import 'package:lettutor/pages/main_page/main_page_bloc.dart';
import 'package:lettutor/pages/tutor_profile_page/tutor_profile_page.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';
import 'package:lettutor/widgets/tutor_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    _homeBloc.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _homeBloc,
      child: Scaffold(
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.indigo),
                  child: Center(child:
                      Consumer<HomeBloc>(builder: (context, homeBloc, _) {
                    return Column(
                      children: [
                        Text(
                          'Total lesson time is ${(homeBloc.totalLearntTime / 60).floor()} hours ${(homeBloc.totalLearntTime.round() % 60)} minutes',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        homeBloc.scheduleList.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, bottom: 8),
                                      child: const Text(
                                        'Upcomming lesson',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      DateFormat(
                                        'hh:mm EEEE, dd MMMM y',
                                      ).format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            homeBloc
                                                    .scheduleList
                                                    .first
                                                    .scheduleDetailInfo
                                                    ?.startPeriodTimestamp ??
                                                0),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: SecondaryButton(
                                          isDisabled: false,
                                          onPressed: () => {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LessonRoomPage(
                                                  startTime: homeBloc
                                                          .scheduleList
                                                          .first
                                                          .scheduleDetailInfo
                                                          ?.startPeriodTimestamp ??
                                                      0,
                                                  name: AppProvider
                                                          .auth?.user?.name ??
                                                      '',
                                                ),
                                              ),
                                            ),
                                          },
                                          text: 'Enter lesson room',
                                        )),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    );
                  })),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Favorite Tutors',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () => MainPageBloc.of(context, listen: false)
                              .changePage(3),
                          child: const Text(
                            'See all tutors ᐳ',
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    )),
                Center(
                  child: StreamBuilder<List>(
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Container(
                            margin: const EdgeInsets.only(top: 200),
                            child:
                                const Text('Add a favorite tutor to your list'),
                          );
                        }
                        return Column(
                          children: snapshot.data!
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: TutorCard(
                                    tutor: e,
                                    onClickCard: () =>
                                        Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TutorProfilePage(
                                          tutorId: e.userId ?? e.user!.id!,
                                        ),
                                      ),
                                    ),
                                    needReload: () =>
                                        _homeBloc.initialize(context),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.only(top: 200),
                          child: const CircularProgressIndicator(),
                        );
                      }
                    },
                    stream: _homeBloc.tutorsStream,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
