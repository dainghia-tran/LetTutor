import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({Key? key, required this.name, required this.tutorId})
      : super(key: key);

  final String tutorId;
  final String name;

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Report ${widget.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_sharp))
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.report,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        "Help us understand what's happening",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Let us know details about your problem',
                  ),
                  maxLines: 5,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SecondaryButton(
                        isDisabled: false,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Cancel'),
                    PrimaryButton(
                        isDisabled: false,
                        onPressed: () {
                          sendReport(context);
                        },
                        text: 'Submit')
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendReport(BuildContext context) async {
    try {
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      var dio = Http().client;
      dio.options.headers["Authorization"] = "Bearer $accessToken";

      await dio.post(
        "report",
        data: {
          "tutorId": widget.tutorId,
          "content": textController.text,
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Report sent",
          ),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      inspect(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (e as DioError).response?.data["message"],
          ),
        ),
      );
    }
  }
}
