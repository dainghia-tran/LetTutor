import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Course extends StatelessWidget {
  const Course(
      {Key? key,
      required this.courseName,
      required this.description,
      required this.price,
      required this.level,
      required this.onPressed})
      : super(key: key);

  final courseName;
  final description;
  final price;
  final level;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
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
                  imageUrl:
                      'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1385191091i/52084.jpg',
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Expanded(child: SizedBox()),
                      Text('$level • $price lesson')
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
