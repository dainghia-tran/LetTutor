import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/pages/main_page/upcoming_page/upcoming_provider.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';
import 'package:lettutor/widgets/schedule_card.dart';
import 'package:provider/provider.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  _UpcomingPageState createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage>
    with AutomaticKeepAliveClientMixin {
  final UpcomingProvider _upcomingProvider = UpcomingProvider();

  @override
  void initState() {
    super.initState();
    _upcomingProvider.getSchedules(true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: _upcomingProvider,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Upcoming',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Consumer<UpcomingProvider>(builder: (_, prov, __) {
          return CustomScrollView(
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
              prov.scheduleList.isNotEmpty
                  ? _schedules()
                  : prov.loading == true
                      ? const SliverToBoxAdapter()
                      : SliverToBoxAdapter(
                          child: Container(
                            margin: const EdgeInsets.only(top: 200),
                            child: const Text(
                              "No data",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 20),
                          ),
                        ),
              if (prov.page * prov.perPage < prov.count && !prov.loading)
                SliverToBoxAdapter(
                  child: Container(
                    child: SecondaryButton(
                      text: "Load more",
                      onPressed: () async {
                        prov.page += 1;
                        await prov.getSchedules(false);
                      },
                      isDisabled: false,
                    ),
                    margin: const EdgeInsets.only(
                      top: 16,
                      bottom: 4,
                    ),
                  ),
                ),
              if (prov.loading)
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 200),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  SliverList _schedules() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final schedule = _upcomingProvider.scheduleList[index];
        return ScheduleCard(
          schedule: schedule,
          onEdit: () async {
            await _upcomingProvider.getSchedules(true);
          },
        );
      }, childCount: _upcomingProvider.scheduleList.length),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
