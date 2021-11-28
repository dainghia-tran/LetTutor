import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/utils/tutor_utils.dart' as tutor_utils;
import 'package:lettutor/widgets/button/secondary_button_rounded.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';
import 'package:lettutor/widgets/star_rating_bar.dart';
import 'package:lettutor/widgets/tag.dart';

class TutorCard extends StatefulWidget {
  const TutorCard(
      {Key? key,
      required this.tutor,
      required this.onClickBook,
      required this.onClickMessage})
      : super(key: key);

  final Tutor tutor;
  final onClickBook;
  final onClickMessage;

  @override
  _TutorCardState createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  var _isFavorite = false;
  final List<Widget> _tags = [];

  @override
  void initState() {
    super.initState();
    _isFavorite = false;
    tutor_utils
        .getTagsFromSpecialities(widget.tutor.specialties)
        .forEach((tag) => _tags.add(Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
              child: Tag(text: tag, isActive: true),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCircleAvatar(avatarUrl: widget.tutor.avatar ?? ''),
                Icon(_isFavorite ? Boxicons.bxs_heart : Boxicons.bx_heart,
                    color: _isFavorite ? Colors.red : Colors.blue),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.tutor.name ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            StarRatingBar(
                stars: tutor_utils
                    .getRatingFromFeedbacks(widget.tutor.feedbacks ?? [])),
            Wrap(children: _tags),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.tutor.bio ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButtonRounded(
                  isDisabled: false,
                  onPressed: widget.onClickBook,
                  text: 'Book',
                  icon: Boxicons.bx_calendar_check,
                ),
                SecondaryButtonRounded(
                  isDisabled: false,
                  onPressed: widget.onClickMessage,
                  text: 'Message',
                  icon: Boxicons.bx_message_dots,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
