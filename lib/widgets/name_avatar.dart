import 'dart:math';

import 'package:flutter/material.dart';

class NameAvatar extends StatelessWidget {
  const NameAvatar({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    List<String> seperatedName = name.split(' ');
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orange,
      ),
      child: Text(
        '${seperatedName[0][0]}${seperatedName[seperatedName.length - 1][0]}',
        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 56),
      ),
    );
  }
}
