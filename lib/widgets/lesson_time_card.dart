import 'package:flutter/material.dart';
import 'package:lettutor/pages/lesson_room_page/lesson_room_page.dart';
import 'package:lettutor/widgets/button/primary_button_rounded.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';

class LessonTimeCard extends StatefulWidget {
  const LessonTimeCard({Key? key, required this.lessonTime}) : super(key: key);

  final lessonTime;

  @override
  _LessonTimeCardState createState() => _LessonTimeCardState();
}

class _LessonTimeCardState extends State<LessonTimeCard> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue),
        color: Colors.white
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lesson Time: ${widget.lessonTime}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SecondaryButton(
                isDisabled: false,
                onPressed: () {},
                text: 'Cancel',
                height: 40,
                icon: Icons.close_outlined,
                color: Colors.redAccent,
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blueGrey)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                children: [
                  Container(
                    color: Colors.blueGrey,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.white,),
                          onPressed: () => setState(() {
                            isExpanded = !isExpanded;
                          }),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Request for lesson',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Edit request',
                            style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      color: Colors.white,
                      height: isExpanded ? null : 0,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: const Text(
                        'Currently there are no requests for this class. Please write down any requests for the teacher.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8,),
          PrimaryButtonRounded(isDisabled: false, onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LessonRoomPage())), text: 'Enter lesson room')
        ],
      ),
    );
  }
}
