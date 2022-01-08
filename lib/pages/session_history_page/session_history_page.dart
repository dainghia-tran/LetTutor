import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/widgets/lession_history_card.dart';
import 'package:lettutor/widgets/schedule_card.dart';

class SessionHistoryPage extends StatefulWidget {
  const SessionHistoryPage({Key? key}) : super(key: key);

  @override
  _SessionHistoryPageState createState() => _SessionHistoryPageState();
}

class _SessionHistoryPageState extends State<SessionHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              pinned: true,
              snap: false,
              expandedHeight: 200,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: top <= 100 ? 1.0 : 0.0,
                      child: const Text(
                        'Session history',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    background: SizedBox(
                        height: 50,
                        width: 50,
                        child: SvgPicture.asset(
                          'assets/schedule.svg',
                        )),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'The following is a list of lessons you have attended',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'You can review the details of the lessons you have attended',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
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
            SliverAppBar(
              automaticallyImplyLeading: false,
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
          ],
        ),
      ),
    );
  }
}
