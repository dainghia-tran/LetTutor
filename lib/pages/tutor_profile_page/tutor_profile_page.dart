import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/pages/private_message/private_message_page.dart';
import 'package:lettutor/pages/tutor_profile_page/widgets/book_schedule_dialog.dart';
import 'package:lettutor/pages/tutor_profile_page/widgets/report_dialog.dart';
import 'package:lettutor/pages/tutor_profile_page/widgets/reviews_dialog.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';
import 'package:lettutor/widgets/expandable_text.dart';
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:lettutor/widgets/star_rating_bar.dart';
import 'package:lettutor/widgets/tag.dart';
import 'package:lettutor/widgets/time_table.dart';

class TutorProfilePage extends StatefulWidget {
  const TutorProfilePage({Key? key}) : super(key: key);

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
          onPressed: () {},
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
                      const CustomCircleAvatar(
                          dimention: 100,
                          avatarUrl:
                              'https://img.freepik.com/free-vector/cute-koala-with-cub-cartoon-icon-illustration_138676-2839.jpg?size=338&ext=jpg'),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Tran Nghia',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            StarRatingBar(stars: 4.5),
                            Text('🇻🇳 Vietnamese')
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const ExpandableText(content: desciption),
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
                                const PrivateMessagePage(name: 'Tran Nghia'),
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
                            builder: (context) => const ReportDialog(
                              name: 'Tran Nghia',
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
                            builder: (context) => const ReviewsDialog(),
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
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: 'Vietnamese',
                            isActive: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: 'English',
                            isActive: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: 'Russian',
                            isActive: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Specialities',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Wrap(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: 'English for business',
                            isActive: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: 'Conversational',
                            isActive: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: 'English for kids',
                            isActive: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Tag(
                            text: 'Starters',
                            isActive: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Suggested courses',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: RichText(
                      text: const TextSpan(
                          text: 'Business English: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: 'Link',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal))
                          ]),
                    ),
                  ),
                  const Text(
                    'Interests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Cooking, Mingling with kids, Watch my small retail store, Travelling',
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                  const Text(
                    'Teaching experience',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'I have been teaching English online since 2020 catering to Japanese and Chinese students.',
                      style: TextStyle(color: Colors.black45),
                    ),
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
                        'Oct, 2021',
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

const desciption =
    "Hi, My name is Nghia I am an experienced English Teacher from Vietnam. I would like share my enthusiasm with the learners in this platform. I've been working with diverse learners of all levels for many years. I am greatly passionate about about profession. I love teaching because I can help others improve their skills and it gives me joy and excitement meeting different learners around the world. In my class I worked with wonderful enthusiasm and positivity, and I'm happy t focus on my learner's goal.";
