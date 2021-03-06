import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/widgets/lesson_time_card.dart';
import 'package:lettutor/widgets/tutor_card_compact.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  _UpcomingPageState createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Upcoming',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/schedule.svg'),
                    const Text(
                      'Here is a list of the sessions you have booked',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      'You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            SliverAppBar(
              centerTitle: false,
              leadingWidth: 0,
              backgroundColor: Colors.lightGreen,
              pinned: true,
              title: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Wed, 20 Oct 21',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      '2 consecutive lessons',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              TutorCardCompat(
                  tutorName: 'Tran Nghia',
                  national: 'Vietnam',
                  onPressDM: () {}),
              const Padding(
                padding: EdgeInsets.all(16),
                child: LessonTimeCard(lessonTime: '00:00 - 00:25'),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: LessonTimeCard(lessonTime: '00:30 - 00:55'),
              ),
              TutorCardCompat(
                  tutorName: 'Elise Vu',
                  national: 'Vietnam',
                  onPressDM: () {}),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: LessonTimeCard(lessonTime: '00:30 - 00:55'),
              ),
            ])),
            SliverAppBar(
              centerTitle: false,
              leadingWidth: 0,
              backgroundColor: Colors.grey,
              pinned: true,
              title: Container(
                color: Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Thu, 21 Oct 21',
                      style: TextStyle(color: Colors.black87),
                    ),
                    Text(
                      '2 consecutive lessons',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  TutorCardCompat(
                      tutorName: 'Tran Nghia',
                      national: 'Vietnam',
                      onPressDM: () {}),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: LessonTimeCard(lessonTime: '00:00 - 00:25'),
                  ),
                  TutorCardCompat(
                      tutorName: 'Elise Vu',
                      national: 'Vietnam',
                      onPressDM: () {}),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: LessonTimeCard(lessonTime: '00:30 - 00:55'),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: LessonTimeCard(lessonTime: '00:30 - 00:55'),
                  ),
            ]))
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
