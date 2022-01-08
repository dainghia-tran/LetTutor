import 'package:flutter/material.dart';
import 'package:lettutor/utils/time_utils.dart' as time_utils;
import 'package:lettutor/widgets/custom_circle_avatar.dart';
import 'package:lettutor/widgets/star_rating_bar.dart';

class UserReview extends StatelessWidget {
  const UserReview({Key? key, required this.feedback}) : super(key: key);
  final feedback;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCircleAvatar(
            dimension: 32, avatarUrl: feedback.firstInfo?.avatar ?? ''),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      feedback.firstInfo?.name ?? '',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      time_utils.getRelativeTime(feedback.createdAt ?? ''),
                      style: const TextStyle(color: Colors.black12),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
              StarRatingBar(stars: feedback.rating?.toDouble() ?? 0),
              Text(feedback.content ?? '')
            ],
          ),
        )
      ],
    );
  }
}
