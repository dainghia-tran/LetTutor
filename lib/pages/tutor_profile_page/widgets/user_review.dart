import 'package:flutter/material.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';
import 'package:lettutor/widgets/star_rating_bar.dart';

class UserReview extends StatelessWidget {
  const UserReview({Key? key, required this.username, required this.content, required this.rating}) : super(key: key);
  final username;
  final content;
  final rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomCircleAvatar(height: 32, avatarUrl: 'https://uploads.scratch.mit.edu/users/avatars/61790528.png'),
        const SizedBox(width: 12,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(username, style: const TextStyle(color: Colors.black54),),
                const SizedBox(width: 4,),
                const Text('a month ago', style: TextStyle(color: Colors.black12),)
              ],
            ),
            StarRatingBar(stars: rating),
            Text(content)
          ],
        )
      ],
    );
  }
}
