import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final bool isDisabled;
  final onPressed;
  final String text;

  const PrimaryButton(
      {Key? key,
        required this.isDisabled,
        required this.onPressed,
        required this.text})
      : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: widget.isDisabled ? null : widget.onPressed,
      fillColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(widget.text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}