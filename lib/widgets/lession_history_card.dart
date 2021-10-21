import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LessonHistoryCard extends StatelessWidget {
  const LessonHistoryCard({Key? key, required this.lessonTime}) : super(key: key);
  final lessonTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue),
          color: Colors.white
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lesson Time: $lessonTime',
            style:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blueGrey)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.blueGrey,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('No request for lesson', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),),
                    Divider(),
                    Text("Tutor hasn't reviewed yet", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
