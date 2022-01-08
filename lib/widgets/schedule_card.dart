import 'package:flutter/material.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/widgets/lesson_time_card.dart';
import 'package:lettutor/widgets/tutor_card_compact.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({Key? key, required this.schedule, required this.onEdit})
      : super(key: key);

  final Schedule schedule;
  final VoidCallback onEdit;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TutorCardCompat(
              tutorName: widget.schedule.scheduleDetailInfo?.scheduleInfo
                      ?.tutorInfo?.name ??
                  '',
              national: widget.schedule.scheduleDetailInfo?.scheduleInfo
                      ?.tutorInfo?.country ??
                  "VN",
              avatar: widget.schedule.scheduleDetailInfo?.scheduleInfo
                      ?.tutorInfo?.avatar ??
                  ''),
          const SizedBox(height: 16),
          LessonsTimeCard(schedule: widget.schedule, onEdit: widget.onEdit),
        ],
      ),
    );
  }
}
