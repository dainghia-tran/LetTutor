import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/pages/courses_page/courses_provider.dart';
import 'package:lettutor/pages/courses_page/widgets/course_card.dart';
import 'package:lettutor/pages/explore_course_page/explore_course_page.dart';
import 'package:lettutor/pages/profile_page/components/tag_list_selector.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';
import 'package:lettutor/widgets/search_bar.dart';
import 'package:provider/provider.dart';

const level = ["Beginner", "Intermediate", "Advanced"];

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final CoursesProvider _coursesProvider = CoursesProvider();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _coursesProvider.getCategories();
    _coursesProvider.getCourseList(true, '');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _coursesProvider,
      child: Scaffold(body: SafeArea(
        child: Consumer<CoursesProvider>(builder: (_, prov, __) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0,
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
              SliverAppBar(
                elevation: 0,
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: Container(
                  margin: const EdgeInsets.all(8),
                  child: SearchBar(
                    controller: _searchController,
                    onEditingComplete: () async {
                      await prov.getCourseList(true, _searchController.text);
                    },
                  ),
                ),
                titleSpacing: 0,
              ),
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                titleSpacing: 0,
                leadingWidth: 0,
                toolbarHeight: 90,
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Topics',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TagsListSelector(
                              key: Key(prov.categoriesTags.join(',')),
                              tagsList: prov.categoriesTags,
                              isHorizontal: true,
                              onSelectedList: (c) async {
                                prov.selectedCategories =
                                    prov.convertCategoriesToId(c);
                                await prov.getCourseList(
                                    true, _searchController.text);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Levels',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TagsListSelector(
                              tagsList: prov.levelsTag,
                              isHorizontal: true,
                              onSelectedList: (p) async {
                                prov.selectedLevels =
                                    prov.convertLevelToIndex(p);
                                await prov.getCourseList(
                                    true, _searchController.text);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              (prov.courseList.isNotEmpty)
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final course = prov.courseList[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: CourseCard(
                              courseData: course,
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ExploreCoursePage(),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: prov.courseList.length,
                      ),
                    )
                  : (prov.isLoading)
                      ? const SliverToBoxAdapter()
                      : SliverToBoxAdapter(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            child: const Center(
                              child: Text(
                                "No courses found",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
              if (prov.size * prov.page < prov.count && !prov.isLoading)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SecondaryButton(
                      text: "Load more",
                      onPressed: () async {
                        prov.page += 1;
                        await prov.getCourseList(false, _searchController.text);
                      },
                      isDisabled: false,
                    ),
                  ),
                ),
              if (prov.isLoading)
                SliverToBoxAdapter(
                  child: Container(
                    child: const Center(child: CircularProgressIndicator()),
                    padding: const EdgeInsets.only(top: 20),
                  ),
                )
            ],
          );
        }),
      )),
    );
  }
}
