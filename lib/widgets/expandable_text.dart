import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({Key? key, required this.content}) : super(key: key);
  final String content;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.content.length > 100) {
      firstHalf = widget.content.substring(0, 100);
      secondHalf = widget.content.substring(100, widget.content.length);
    } else {
      firstHalf = widget.content;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
        children: <Widget>[
          Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Text(
                  flag ? "show more" : "show less",
                  style: const TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  setState(() {
                    flag = !flag;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
