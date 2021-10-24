import 'package:flutter/material.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';

class TutorCardCompat extends StatelessWidget {
  const TutorCardCompat({Key? key, required this.tutorName, required this.national, required this.onPressDM}) : super(key: key);
  final tutorName;
  final national;
  final onPressDM;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CustomCircleAvatar(avatarUrl: 'https://dev.api.lettutor.com/avatar/3b994227-2695-44d4-b7ff-333b090a45d4avatar1632047402615.jpg', dimension: 50,),
          const SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tutorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text('🇻🇳 $national', style: const TextStyle(fontSize: 12),),
              GestureDetector(
                onTap: onPressDM,
                child: Row(
                  children: const [
                    Icon(Icons.message_outlined, color: Colors.blue, size: 16,),
                    SizedBox(width: 2,),
                    Text('Direct Message', style: TextStyle(fontSize: 12),)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
