import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText({Key? key, required this.content}) : super(key: key);
  final String content;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new ConstrainedBox(
          constraints: isExpanded
              ? new BoxConstraints()
              : new BoxConstraints(maxHeight: 50.0),
          child: new Text(
            widget.content,
            softWrap: true,
            overflow: TextOverflow.clip,
          )),
      isExpanded
          ? new Container()
          : new FlatButton(
          child: const Text('...'),
          onPressed: () => setState(() => isExpanded = true))
    ]);
  }
}
