import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/pages/booking_history_page/widgets/lesson_history_item.dart';
import 'package:timeago/timeago.dart' as timeago;

class BookingHistoryItem extends StatefulWidget {
  const BookingHistoryItem({Key? key, required this.schedule})
      : super(key: key);

  final Schedule schedule;

  @override
  State<BookingHistoryItem> createState() => _BookingHistoryItemState();
}

class _BookingHistoryItemState extends State<BookingHistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EE, dd MMM y').format(
              DateTime.fromMillisecondsSinceEpoch(
                  widget.schedule.scheduleDetailInfo?.startPeriodTimestamp ??
                      0),
            ),
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Text(
              timeago.format(widget.schedule.createdAt ?? DateTime.now()),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 70,
                        height: 70,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                            widget.schedule.scheduleDetailInfo?.scheduleInfo
                                    ?.tutorInfo?.avatar ??
                                '',
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          widget.schedule.scheduleDetailInfo?.scheduleInfo
                                  ?.tutorInfo?.name ??
                              '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CountryCodePicker(
                        initialSelection: widget.schedule.scheduleDetailInfo
                                ?.scheduleInfo?.tutorInfo?.country ??
                            "VN",
                        showOnlyCountryWhenClosed: true,
                        enabled: false,
                        alignLeft: false,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              LessonHistoryItem(schedule: widget.schedule),
            ],
          ),
        ],
      ),
    );
  }
}
