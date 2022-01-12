import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/course.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(
      {Key? key, required this.courseData, required this.onPressed})
      : super(key: key);

  final Course courseData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  imageUrl: courseData.imageUrl ?? '',
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseData.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        courseData.description ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                          '${courseData.level} • ${courseData.topics?.length} lesson')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
