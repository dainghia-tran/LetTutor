import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EBook extends StatelessWidget {
  const EBook(
      {Key? key,
      required this.name,
      required this.description,
      required this.level})
      : super(key: key);

  final name;
  final description;
  final level;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey)),
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
            )),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text(description, maxLines: 5, overflow: TextOverflow.ellipsis,),
                    const Expanded(child: SizedBox()),
                    Text(level)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
