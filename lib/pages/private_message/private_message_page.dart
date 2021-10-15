import 'package:flutter/material.dart';
import 'package:lettutor/widgets/custom_circle_avatar.dart';

class PrivateMessagePage extends StatefulWidget {
  const PrivateMessagePage({Key? key, this.name}) : super(key: key);
  final name;

  @override
  _PrivateMessagePageState createState() => _PrivateMessagePageState();
}

class _PrivateMessagePageState extends State<PrivateMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            const CustomCircleAvatar(
              avatarUrl:
                  'https://img.freepik.com/free-vector/cute-koala-with-cub-cartoon-icon-illustration_138676-2839.jpg?size=338&ext=jpg',
              height: 32,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.name,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        hintText: 'Type your message here',
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
