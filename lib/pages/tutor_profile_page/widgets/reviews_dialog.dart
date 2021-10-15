import 'package:flutter/material.dart';
import 'package:lettutor/pages/tutor_profile_page/widgets/user_review.dart';

class ReviewsDialog extends StatelessWidget {
  const ReviewsDialog({Key? key}) : super(key: key);

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
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
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
                itemCount: 20,
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: UserReview(username: 'Hari', content: content, rating: 4.5,),
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
