import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final bool isDisabled;
  final onPressed;
  final String text;
  final double? width;
  final double? height;
  final IconData? icon;
  final Color? color;

  const PrimaryButton(
      {Key? key,
      required this.isDisabled,
      required this.onPressed,
      required this.text,
      this.width,
      this.height,
      this.icon,
      this.color})
      : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  Widget icon = Container();

  @override
  void initState() {
    super.initState();
    if (widget.icon != null) {
      icon = Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          widget.icon,
          size: 16,
          color:
              widget.isDisabled ? Colors.grey : (widget.color ?? Colors.white),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: widget.isDisabled ? null : widget.onPressed,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.isDisabled
                            ? Colors.grey
                            : (widget.color ?? Colors.white),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
