import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  _UpcomingPageState createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Upcoming', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.message_outlined),
            Text('No data')
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
