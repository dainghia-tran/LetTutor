import 'package:flutter/material.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/widgets/fullscreen_dialog.dart';

class LessonHistoryItem extends StatefulWidget {
  const LessonHistoryItem({Key? key, required this.schedule}) : super(key: key);
  final Schedule schedule;
  @override
  _LessonHistoryItemState createState() => _LessonHistoryItemState();
}

class _LessonHistoryItemState extends State<LessonHistoryItem> {
  displayDialog(BuildContext context, String title, Widget content) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            FullScreenDialog(title: title, content: content),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Lesson Time: ${widget.schedule.scheduleDetailInfo?.startPeriod ?? "00: 00"} - ${widget.schedule.scheduleDetailInfo?.endPeriod ?? "00: 00"}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Table(
            border: TableBorder.all(
              color: const Color(0xfff0f0f0),
              style: BorderStyle.solid,
              width: 1,
            ),
            children: [
              TableRow(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      (widget.schedule.studentRequest ?? 'No request'),
                      style: const TextStyle(
                        color: Color(0xff8399a7),
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      (widget.schedule.tutorReview ?? 'No reviews'),
                      style: const TextStyle(
                        color: Color(0xff8399a7),
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
