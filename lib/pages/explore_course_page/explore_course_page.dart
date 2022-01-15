import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lettutor/models/course.dart';
import 'package:lettutor/pages/discover_topic_page/discover_topic_page.dart';
import 'package:lettutor/widgets/topic_item.dart';

class ExploreCoursePage extends StatefulWidget {
  const ExploreCoursePage({Key? key, required this.courseData})
      : super(key: key);

  final Course courseData;

  @override
  _ExploreCoursePageState createState() => _ExploreCoursePageState();
}

class _ExploreCoursePageState extends State<ExploreCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Explore Course',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                CachedNetworkImage(imageUrl: widget.courseData.imageUrl ?? ''),
                Positioned(
                  bottom: -30,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.2))
                        ]),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.courseData.topics?.length.toString() ??
                                  '0',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                  fontSize: 28),
                            ),
                            const Text(
                              'Topics',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Column(
                          children: const [
                            Text(
                              '1',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                            Text(
                              'Tutor',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                widget.courseData.name ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Course',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(
                      widget.courseData.description ?? '',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const Text(
                    'Overview',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Why should you learn this course?',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      widget.courseData.reason ?? '',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'What will you be able to do?',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      widget.courseData.purpose ?? '',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const Text(
                    'Level',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(widget.courseData.level ?? '',
                        style: const TextStyle(color: Colors.black54)),
                  ),
                  const Text(
                    'Topic',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  for (int i = 0; i < widget.courseData.topics!.length; i++)
                    Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        TopicItem(
                          content: widget.courseData.topics![i].name ?? '',
                          order: i + 1,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DiscoverTopicPage(
                                  topicData: widget.courseData.topics![i],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
