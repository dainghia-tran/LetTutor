import 'package:flutter/material.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';
import 'package:lettutor/widgets/expandable_text.dart';

class BookingHistoryItem extends StatelessWidget {
  const BookingHistoryItem(
      {Key? key, required this.tutorName, required this.time, this.requires})
      : super(key: key);

  final tutorName;
  final time;
  final String? requires;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(16),
          color: Colors.white),
      padding: const EdgeInsets.all(16),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              children: [
                const CustomCircleAvatar(
                  avatarUrl:
                      'http://static.boredpanda.com/blog/wp-content/uploads/2019/12/62144452_2261755747276811_7262549243119500388_n-5df0419c10749__700.jpg',
                  dimension: 70,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  tutorName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const VerticalDivider(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lesson time: $time',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8,),
                  if (requires != null) Expanded(child: ExpandableText(content: 'Notes: ${requires ?? ''}')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
