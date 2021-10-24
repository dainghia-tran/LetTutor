import 'package:flutter/material.dart';

class DiscoverTopicPage extends StatefulWidget {
  const DiscoverTopicPage({Key? key}) : super(key: key);

  @override
  _DiscoverTopicPageState createState() => _DiscoverTopicPageState();
}

class _DiscoverTopicPageState extends State<DiscoverTopicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Discover',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text(
          'PDF Viewer'
        ),
      ),
    );
  }
}
