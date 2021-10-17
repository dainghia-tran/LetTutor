import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  const DividerText({Key? key, required this.text}) : super(key: key);
  final text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(child: Divider()),
      const SizedBox(width: 4,),
      Text(text, style: const TextStyle(fontWeight: FontWeight.bold),),
      const SizedBox(width: 4,),
      const Expanded(child: Divider()),
    ]);
  }
}
