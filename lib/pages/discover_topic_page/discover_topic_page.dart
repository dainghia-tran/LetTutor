import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lettutor/models/topic.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DiscoverTopicPage extends StatefulWidget {
  const DiscoverTopicPage({Key? key, required this.topicData})
      : super(key: key);

  final Topic topicData;
  @override
  _DiscoverTopicPageState createState() => _DiscoverTopicPageState();
}

class _DiscoverTopicPageState extends State<DiscoverTopicPage> {
  Completer<WebViewController>? _webViewController;
  String webViewUrl = '';

  @override
  void initState() {
    super.initState();
    _webViewController = Completer<WebViewController>();
    webViewUrl =
        "https://drive.google.com/viewerng/viewer?url=${widget.topicData.videoUrl}?pid=explorer&efh=false&a=v&chrome=false&embedded=true";
  }

  @override
  Widget build(BuildContext context) {
    inspect(widget.topicData);
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
        title: Text(
          widget.topicData.name ?? '',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Center(
        child: (widget.topicData.videoUrl != null)
            ? WebView(
                initialUrl: webViewUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (c) => _webViewController?.complete(c),
              )
            : const Text(
                'No url found for this topic',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
