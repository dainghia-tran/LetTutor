import 'package:flutter/material.dart';
import 'package:lettutor/models/tutor/feedback.dart' as tutor_feedback;
import 'package:lettutor/pages/tutor_profile_page/widgets/user_review.dart';

class ReviewsDialog extends StatelessWidget {
  const ReviewsDialog({Key? key, required this.feedbacks}) : super(key: key);
  final List<tutor_feedback.Feedback> feedbacks;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Others review',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close_sharp))
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ListView.builder(
                  itemCount: feedbacks.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: UserReview(
                      feedback: feedbacks[index],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const content = 'He is very friendly';
