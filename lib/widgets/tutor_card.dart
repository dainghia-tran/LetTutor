import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/tutor.dart';
import 'package:lettutor/utils/tutor_utils.dart' as tutor_utils;
import 'package:lettutor/widgets/custom_circle_avatar.dart';
import 'package:lettutor/widgets/star_rating_bar.dart';
import 'package:lettutor/widgets/tag.dart';

class TutorCard extends StatefulWidget {
  const TutorCard({
    Key? key,
    required this.tutor,
    required this.onClickCard,
  }) : super(key: key);

  final Tutor tutor;
  final onClickCard;

  @override
  _TutorCardState createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  var _isFavorite = false;
  final List<Widget> _tags = [];

  @override
  void initState() {
    inspect(widget.tutor);
    super.initState();
    _isFavorite = _isFavorite = widget.tutor.isFavorite ?? false;
    tutor_utils.getTagsFromSpecialities(widget.tutor.specialties).forEach(
          (tag) => _tags.add(
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
              child: Tag(text: tag, isActive: true),
            ),
          ),
        );

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.get(
        "tutor/${widget.tutor.user == null ? widget.tutor.userId : (widget.tutor.user?.id ?? "")}",
      );
      Tutor data = Tutor.fromJson(res.data);
      setState(() {
        _isFavorite = data.isFavorite ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: widget.onClickCard,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCircleAvatar(avatarUrl: widget.tutor.avatar ?? ''),
                  GestureDetector(
                    onTap: () async {
                      await AppProvider.setFavorite(
                          widget.tutor.user?.id ?? (widget.tutor.userId ?? ''));
                    },
                    child: Icon(
                        _isFavorite ? Boxicons.bxs_heart : Boxicons.bx_heart,
                        color: _isFavorite ? Colors.red : Colors.blue),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.tutor.name ?? '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              StarRatingBar(
                stars: tutor_utils
                    .getRatingFromFeedbacks(widget.tutor.feedbacks ?? []),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
