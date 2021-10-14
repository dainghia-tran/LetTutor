import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lettutor/widgets/button/primary_button_rounded.dart';

class TimeTable extends StatelessWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(children: [
          Container(
            height: 50,
            width: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFD3D6DB),
              border: Border.all(color: Colors.black26, width: 1),
            ),
          ),
          for (var i = 0; i < 17; ++i)
            Container(
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFD3D6DB),
                border: Border.all(color: Colors.black26, width: 1),
              ),
              child: Center(
                child: Text(
                  '${(i + 6).toString().padLeft(2, '0')}:${(i % 2 == 0 ? 30 : 00).toString().padLeft(2, '0')} - ${(i + 6).toString().padLeft(2, '0')}:55',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ]),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < 7; ++i)
                  Column(children: [
                    Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                      ),
                      child: Center(
                        child: Text(getWeekDay(i)),
                      ),
                    ),
                    for (var i = 0; i < 17; ++i)
                      Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1),
                        ),
                        child: Center(
                          child: getRandomStatus()
                        ),
                      ),
                  ])
              ],
            ),
          ),
        )
      ],
    );
  }
}

String getWeekDay(int order) {
  switch (order) {
    case 0:
      return 'Monday';
    case 1:
      return 'Tuesday';
    case 2:
      return 'Wednesday';
    case 3:
      return 'Thursday';
    case 4:
      return 'Friday';
    case 5:
      return 'Saturday';
    default:
      return 'Sunday';
  }
}

Widget getRandomStatus(){
  final rand = Random();
  switch(rand.nextInt(3)){
    case 0:
      return PrimaryButtonRounded(isDisabled: false, onPressed: (){}, text: 'Book',);
    case 1:
      return const Text('Reserved', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),);
    default:
      return Container();
  }
}
