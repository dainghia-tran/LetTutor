import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  const TopicItem({Key? key, required this.order, required this.content}) : super(key: key);

  final order;
  final content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3,
            spreadRadius: 3
          )
        ]
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Center(
              child: Text('$order', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
            ),
          ),
          const SizedBox(width: 8,),
          Expanded(child: Text(content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }
}
