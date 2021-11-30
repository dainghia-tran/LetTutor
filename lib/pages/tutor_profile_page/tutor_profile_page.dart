import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/models/tutor/tutor.dart';
import 'package:lettutor/pages/courses_page/courses_page.dart';
import 'package:lettutor/pages/courses_page/widgets/course.dart';
import 'package:lettutor/pages/explore_course_page/explore_course_page.dart';
import 'package:lettutor/pages/private_message_page/private_message_page.dart';
import 'package:lettutor/pages/tutor_profile_page/widgets/book_schedule_dialog.dart';
import 'package:lettutor/pages/tutor_profile_page/widgets/report_dialog.dart';
import 'package:lettutor/pages/tutor_profile_page/widgets/reviews_dialog.dart';
import 'package:lettutor/utils/tutor_utils.dart' as tutor_utils;
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';
import 'package:lettutor/widgets/expandable_text.dart';
import 'package:lettutor/widgets/star_rating_bar.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/time_table.dart';

class TutorProfilePage extends StatefulWidget {
  const TutorProfilePage({Key? key, required this.tutor}) : super(key: key);

  final Tutor tutor;

  @override
  _TutorProfilePageState createState() => _TutorProfilePageState();
}

class _TutorProfilePageState extends State<TutorProfilePage> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: SizedBox(
            width: 150,
            child: SvgPicture.asset('assets/lettutor_logo.svg',
                semanticsLabel: 'LetTutor logo'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomCircleAvatar(
                          dimension: 100, avatarUrl: widget.tutor.avatar ?? ''),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.tutor.name ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            StarRatingBar(
                                stars: tutor_utils.getRatingFromFeedbacks(
                                    widget.tutor.feedbacks ?? [])),
                            Text(widget.tutor.language ?? '')
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ExpandableText(content: widget.tutor.bio ?? ''),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PrivateMessagePage(tutor: widget.tutor),
                          ));
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.message_outlined,
                              color: Colors.blue,
                            ),
                            Text(
                              'Message',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.blue,
                            ),
                            Text(
                              'Favorite',
                              style: TextStyle(
                                  color: isFavorite ? Colors.red : Colors.blue),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ReportDialog(
                              name: widget.tutor.name ?? '',
                            ),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.report_outlined,
                              color: Colors.blue,
                            ),
                            Text(
                              'Report',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ReviewsDialog(
                                feedbacks: widget.tutor.feedbacks ?? []),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.star_border_rounded,
                              color: Colors.blue,
                            ),
                            Text(
                              'Reviews',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Languages',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Wrap(
                      children:
                          widget.tutor.languages!.split(',').map((element) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: element,
                            isActive: true,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const Text(
                    'Experience',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.tutor.experience ?? '',
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                  const Text(
                    'Education',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.tutor.education ?? '',
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                  const Text(
                    'Interests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.tutor.interests ?? '',
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                  const Text(
                    'Profession',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.tutor.profession ?? '',
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                  const Text(
                    'Specialities',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Wrap(
                        children: tutor_utils
                            .getTagsFromSpecialities(widget.tutor.specialties)
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                                child: Tag(
                                  text: e,
                                  isActive: true,
                                ),
                              ),
                            )
                            .toList()),
                  ),
                  const Text(
                    'Suggested courses',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Course(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ExploreCoursePage())),
                        courseName: 'Bussiness Englist',
                        description: 'Description',
                        price: 100,
                        level: level[Random().nextInt(2).toInt()]),
                  ),
                  Row(
                    children: [
                      PrimaryButton(
                          isDisabled: false, onPressed: () {}, text: 'Today'),
                      const Icon(Icons.arrow_back_ios_sharp),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(Icons.arrow_forward_ios_sharp),
                      const Text(
                        'Dec, 2021',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TimeTable(
                onPressBook: () {
                  showDialog(
                    context: context,
                    builder: (context) => const BookScheduleDialog(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
