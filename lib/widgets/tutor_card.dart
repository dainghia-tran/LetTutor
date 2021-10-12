import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:lettutor/widgets/primary_button.dart';
import 'package:lettutor/widgets/secondary_button.dart';
import 'package:lettutor/widgets/secondary_button_rounded.dart';
import 'package:lettutor/widgets/star_rating_bar.dart';
import 'package:lettutor/widgets/tag.dart';

class TutorCard extends StatefulWidget {
  const TutorCard(
      {Key? key,
      required this.isFavorite,
      required this.name,
      required this.stars,
      this.tags,
      this.description})
      : super(key: key);
  final bool isFavorite;
  final String name;
  final double stars;
  final List<String>? tags;
  final String? description;

  @override
  _TutorCardState createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  var _isFavorite = false;
  final List<Widget> _tags = [];

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    widget.tags?.forEach((tag) => _tags.add(Padding(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    height: 50,
                    imageUrl:
                        'http://static.boredpanda.com/blog/wp-content/uploads/2019/12/62144452_2261755747276811_7262549243119500388_n-5df0419c10749__700.jpg',
                    placeholder: (context, url) =>
                        const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Icon(_isFavorite ? Boxicons.bxs_heart : Boxicons.bx_heart,
                    color: _isFavorite ? Colors.red : Colors.blue),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            StarRatingBar(stars: widget.stars),
            Wrap(children: _tags),
            const SizedBox(height: 16,),
            Text(
              widget.description ?? '',
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButtonRounded(isDisabled: false, onPressed: (){}, text: 'Book', icon: Boxicons.bx_calendar_check,),
                SecondaryButtonRounded(isDisabled: false, onPressed: (){}, text: 'Message', icon: Boxicons.bx_message_dots,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
