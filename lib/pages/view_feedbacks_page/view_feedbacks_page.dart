import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lettutor/models/feedback.dart' as feedback;
import 'package:lettutor/pages/tutor_profile_page/widgets/user_review.dart';

class ViewFeedbacksPage extends StatefulWidget {
  const ViewFeedbacksPage({Key? key, required this.feedbacks})
      : super(key: key);

  final List<feedback.Feedback>? feedbacks;
  @override
  _ViewFeedbacksPageState createState() => _ViewFeedbacksPageState();
}

class _ViewFeedbacksPageState extends State<ViewFeedbacksPage> {
  @override
  Widget build(BuildContext context) {
    inspect(widget.feedbacks);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Feedbacks',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: widget.feedbacks?.length ?? 0,
          itemBuilder: (_, index) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: UserReview(feedback: widget.feedbacks![index])),
        ),
      ),
    );
  }
}
