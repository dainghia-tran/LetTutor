import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({Key? key, required this.text, required this.iconData}) : super(key: key);
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
        )]
      ),
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(width: 16,),
          Expanded(child: Text(text)),
          const Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }
}
