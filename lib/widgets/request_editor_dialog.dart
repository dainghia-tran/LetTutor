import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:provider/provider.dart';

import 'button/secondary_button.dart';

class RequestEditorDialog extends StatefulWidget {
  const RequestEditorDialog({Key? key, required this.scheduleId})
      : super(key: key);
  final String scheduleId;
  @override
  _RequestEditorDialogState createState() => _RequestEditorDialogState();
}

class _RequestEditorDialogState extends State<RequestEditorDialog> {
  bool isSubmitDisabled = true;
  TextEditingController content = TextEditingController();
  Future<bool> updateNote(BuildContext context) async {
    try {
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      await dio.post(
        "booking/student-request/${widget.scheduleId}",
        data: {
          'studentRequest': content.text,
        },
      );
      return true;
    } catch (e) {
      inspect(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Icon(
                    Icons.report,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: cWidth,
                  child: const Text(
                    'Request',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 30, top: 30),
              child: TextFormField(
                minLines: 10,
                maxLines: 20,
                decoration: const InputDecoration(
                  hintText:
                      'You can write your request here (English or Vietnamese and no more than 200 letters)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      isSubmitDisabled = true;
                    } else {
                      isSubmitDisabled = false;
                    }
                  });
                },
                controller: content,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButton(
                  isDisabled: false,
                  onPressed: () => Navigator.of(context).pop(),
                  text: 'Cancel',
                  height: 40,
                  icon: Icons.close_outlined,
                  color: Colors.redAccent,
                ),
                const SizedBox(
                  width: 16,
                ),
                PrimaryButton(
                  isDisabled: isSubmitDisabled,
                  onPressed: () async {
                    bool result = await updateNote(context);
                    if (result == true) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Update note failed, try again later",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    }
                  },
                  text: 'Submit',
                  height: 40,
                  icon: Icons.send,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
