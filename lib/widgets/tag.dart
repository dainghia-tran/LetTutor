import 'package:flutter/material.dart';

class Tag extends StatefulWidget {
  final String text;
  final bool isActive;
  final Function? onClick;

  const Tag(
      {Key? key, required this.text, required this.isActive, this.onClick})
      : super(key: key);

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {
  var isActiveState = false;

  @override
  void initState() {
    super.initState();
    isActiveState = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => {isActiveState = !isActiveState});
        if(widget.onClick != null) {
          widget.onClick!();
        }
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: isActiveState
                    ? const Color(0xFF0071F0)
                    : const Color(0xFF646464)),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              isActiveState ? const Color(0xFFDDEAFF) : const Color(0xFFE4E6EB),
        ),
      ),
    );
  }
}
