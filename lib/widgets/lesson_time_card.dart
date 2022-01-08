import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:lettutor/widgets/request_editor_dialog.dart';

import 'button/secondary_button.dart';
import 'fullscreen_dialog.dart';

class LessonsTimeCard extends StatefulWidget {
  const LessonsTimeCard(
      {Key? key, required this.schedule, required this.onEdit})
      : super(key: key);
  final Schedule schedule;
  final Function onEdit;
  @override
  _LessonsTimeCardState createState() => _LessonsTimeCardState();
}

class _LessonsTimeCardState extends State<LessonsTimeCard> {
  displayDialog(BuildContext context, String title, Widget content) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) =>
            FullScreenDialog(title: title, content: content),
        fullscreenDialog: true,
      ),
    ).then((value) {
      widget.onEdit();
    });
  }

  Future<String?> cancelSchedule(BuildContext context) async {
    try {
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      List<String> ids = [widget.schedule.scheduleDetailId!];
      await dio.delete("booking", data: {
        'scheduleDetailIds[]': ids,
      });
      return null;
    } catch (e) {
      inspect(e);
      return (e as DioError).response?.data['message'] ??
          'Something went wrong';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lesson Time: ${widget.schedule.scheduleDetailInfo?.startPeriod ?? "00: 00"} - ${widget.schedule.scheduleDetailInfo?.endPeriod ?? "00: 00"}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          if (DateTime.now().millisecondsSinceEpoch + 7200000 <
              (widget.schedule.scheduleDetailInfo?.startPeriodTimestamp ?? 0))
            SecondaryButton(
              isDisabled: false,
              onPressed: () async {
                String? result = await cancelSchedule(context);
                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Cancelled schedule',
                      ),
                    ),
                  );
                  widget.onEdit();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        result,
                      ),
                    ),
                  );
                }
              },
              text: 'Cancel',
              height: 40,
              icon: Icons.close,
              color: Colors.redAccent,
            ),
          const SizedBox(height: 8),
          Table(
            border: TableBorder.all(
              color: const Color(0xfff0f0f0),
              style: BorderStyle.solid,
              width: 1,
            ),
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  color: Color(0xfff0f0f0),
                ),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 8,
                              top: 8,
                              bottom: 8,
                            ),
                            child: const Text(
                              'Request for lesson',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  SecondaryButton(
                                    isDisabled: false,
                                    onPressed: () {
                                      displayDialog(
                                        context,
                                        'Request editor',
                                        RequestEditorDialog(
                                          scheduleId: widget.schedule.id!,
                                        ),
                                      );
                                    },
                                    text: 'Edit request',
                                    height: 40,
                                    icon: Icons.edit,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      widget.schedule.studentRequest == null
                          ? 'No request'
                          : (widget.schedule.studentRequest ?? ""),
                      style: const TextStyle(
                        color: Color(0xff8399a7),
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
