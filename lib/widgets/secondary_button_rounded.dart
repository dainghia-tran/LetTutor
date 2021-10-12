import 'package:flutter/material.dart';

class SecondaryButtonRounded extends StatefulWidget {
  final bool isDisabled;
  final onPressed;
  final String text;
  final double? width;
  final double? height;
  final IconData? icon;

  const SecondaryButtonRounded(
      {Key? key,
        required this.isDisabled,
        required this.onPressed,
        required this.text,
        this.width,
        this.height, this.icon})
      : super(key: key);

  @override
  _SecondaryButtonRoundedState createState() => _SecondaryButtonRoundedState();
}

class _SecondaryButtonRoundedState extends State<SecondaryButtonRounded> {
  Widget icon = Container();

  @override
  void initState() {
    super.initState();
    if (widget.icon != null) {
      icon = Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          widget.icon,
          color: Colors.blue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 50,
      width: widget.width,
      child: Card(
          color: widget.isDisabled ? Colors.white10 : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((widget.height ?? 50) / 2),
              side: const BorderSide(
                  color: Colors.blue,
                  width: 1
              )
          ),
          child: InkWell(
              borderRadius: BorderRadius.circular((widget.height ?? 50) / 2),
              onTap: widget.isDisabled ? null : widget.onPressed,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    icon,
                    Text(widget.text, style: const TextStyle(color: Colors.blue),)
                  ],
                ),
              )
          )
      ),
    );
  }
}
