import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/pages/courses_page/widgets/course.dart';
import 'package:lettutor/pages/explore_course_page/explore_course_page.dart';

const level = ["Beginner", "Intermediate", "Advanced"];

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;
                return FlexibleSpaceBar(
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: top <= 100 ? 1.0 : 0.0,
                    child: const Text(
                      'Discover courses',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  background: Padding(
                    padding: const EdgeInsets.all(32),
                    child: SvgPicture.network(
                        'https://dev.app.lettutor.com/static/media/course.0bf1bb71.svg'),
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'English',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildCoursesList('English'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Physics',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildCoursesList('Physics'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Maths',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _buildCoursesList('Maths'),
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ]))
        ],
      ),
    ));
  }

  _buildCoursesList(String category) {
    return List.generate(
      50,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Course(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ExploreCoursePage())),
            courseName: 'Course $category $index',
            description: 'Description $index',
            price: index,
            level: level[Random().nextInt(2).toInt()]),
      ),
    );
  }
}
