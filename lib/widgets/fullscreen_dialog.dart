import 'package:flutter/material.dart';

class FullScreenDialog extends StatefulWidget {
  const FullScreenDialog({Key? key, this.content, this.title = ""})
      : super(key: key);
  final Widget? content;
  final String title;
  @override
  _FullScreenDialogState createState() => _FullScreenDialogState();
}

class _FullScreenDialogState extends State<FullScreenDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: widget.content ?? Container(),
        ),
      ),
    );
  }
}
