import 'package:flutter/material.dart';

class PrimaryButtonRounded extends StatefulWidget {
  final bool isDisabled;
  final onPressed;
  final String text;
  final double? width;
  final double? height;
  final IconData? icon;

  const PrimaryButtonRounded(
      {Key? key,
        required this.isDisabled,
        required this.onPressed,
        required this.text,
        this.width,
        this.height, this.icon})
      : super(key: key);

  @override
  _PrimaryButtonRoundedState createState() => _PrimaryButtonRoundedState();
}

class _PrimaryButtonRoundedState extends State<PrimaryButtonRounded> {
  Widget icon = Container();

  @override
  void initState() {
    super.initState();
    if (widget.icon != null) {
      icon = Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          widget.icon,
          color: Colors.white,
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
          color: widget.isDisabled ? Colors.white10 : Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular((widget.height ?? 50) / 2),
          ),
          child: InkWell(
              borderRadius: BorderRadius.circular((widget.height ?? 50) / 2),
              onTap: widget.isDisabled ? null : widget.onPressed,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    Text(widget.text, style: const TextStyle(color: Colors.white),)
                  ],
                ),
              )
          )
      ),
    );
  }
}
