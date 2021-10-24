import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({Key? key, required this.content, this.style}) : super(key: key);
  final String content;
  final TextStyle? style;

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
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      child: Container(
        child: secondHalf.isEmpty
            ? Text(firstHalf, style: widget.style,)
            : Column(
          children: <Widget>[
            Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf), style: widget.style),
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
      ),
    );
  }
}
