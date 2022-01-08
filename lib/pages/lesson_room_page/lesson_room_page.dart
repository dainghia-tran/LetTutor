import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/pages/lesson_room_page/widgets/call_control.dart';
import 'package:lettutor/widgets/name_avatar.dart';

class LessonRoomPage extends StatefulWidget {
  const LessonRoomPage({Key? key, required this.startTime}) : super(key: key);

  final int startTime;
  @override
  _LessonRoomPageState createState() => _LessonRoomPageState();
}

class _LessonRoomPageState extends State<LessonRoomPage> {
  var _remainingTime = 1712;
  late Timer _timer;

  void startCountDownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        setState(() {
          _timer.cancel();
        });
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startCountDownTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withOpacity(0.7),
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                child: SvgPicture.asset(
                  'assets/lettutor_logo.svg',
                  height: 36,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const NameAvatar(
                      name: 'Tran Nghia',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black.withOpacity(0.5)),
                      child: Text(
                        '${(_remainingTime / 3600).floor()}:${(_remainingTime / 60).floor()}:${_remainingTime % 60} until lesson start (Fri, 23 Oct 21 20:00)',
                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                    )
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CallControl(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
