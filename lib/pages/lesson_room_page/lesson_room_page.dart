import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/pages/lesson_room_page/widgets/call_control.dart';
import 'package:lettutor/widgets/name_avatar.dart';

class LessonRoomPage extends StatefulWidget {
  const LessonRoomPage({Key? key, required this.startTime, required this.name})
      : super(key: key);

  final int startTime;
  final String name;
  @override
  _LessonRoomPageState createState() => _LessonRoomPageState();
}

class _LessonRoomPageState extends State<LessonRoomPage> {
  var _remainingTime = 0;
  var _elapsedTime = 0;
  late Timer _countDownTimer;
  late Timer _countUpTimer;
  late final DateTime startDate;

  void startCountDownTimer() {
    _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        setState(() {
          _countDownTimer.cancel();
        });
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void startCountUpTimer() {
    _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _remainingTime = DateTime.fromMillisecondsSinceEpoch(widget.startTime)
        .difference(DateTime.now())
        .inSeconds;
    startCountDownTimer();
    startCountUpTimer();
    startDate = DateTime.fromMillisecondsSinceEpoch(widget.startTime);
  }

  @override
  void dispose() {
    super.dispose();
    _countDownTimer.cancel();
    _countUpTimer.cancel();
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
              Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black.withOpacity(0.5)),
                    child: Text(
                      '${_elapsedTime ~/ 3600}:${(_elapsedTime % 3600 / 60).floor()}:${_elapsedTime % 60}',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  )),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NameAvatar(
                      name: widget.name,
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
                        '${(_remainingTime ~/ 3600).floor()}:${(_remainingTime % 3600 / 60).floor()}:${_remainingTime % 60} until lesson start (${DateFormat('EEEE dd MMMM HH:mm').format(startDate)})',
                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
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
