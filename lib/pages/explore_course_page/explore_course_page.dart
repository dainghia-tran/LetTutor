import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lettutor/widgets/topic_item.dart';

class ExploreCoursePage extends StatefulWidget {
  const ExploreCoursePage({Key? key}) : super(key: key);

  @override
  _ExploreCoursePageState createState() => _ExploreCoursePageState();
}

class _ExploreCoursePageState extends State<ExploreCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  CachedNetworkImage(
                      imageUrl:
                          'https://camblycurriculumicons.s3.amazonaws.com/5e2b895e541a832674533c18?h=d41d8cd98f00b204e9800998ecf8427e'),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                  ),
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
                            children: const [
                              Text(
                                '3',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                    fontSize: 28),
                              ),
                              Text(
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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About Course',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 16),
                      child: Text(
                        'The English you need for work and career',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    const Text(
                      'Overview',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                        style: TextStyle(color: Colors.black54),
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    const Text(
                      'Level',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 16),
                      child: Text('4'),
                    ),
                    const Text(
                      'Topic',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(height: 12,),
                    const TopicItem(order: 1, content: 'Phone Conversations'),
                    const SizedBox(height: 12,),
                    const TopicItem(order: 2, content: 'Meetings'),
                    const SizedBox(height: 12,),
                    const TopicItem(order: 3, content: 'Work Styles'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
