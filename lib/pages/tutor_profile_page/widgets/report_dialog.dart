import 'package:flutter/material.dart';
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({Key? key, required this.name}) : super(key: key);
  final name;

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  var cbAnnoying = false;
  var cbFake = false;
  var cvInappropriate = false;
  final textController = TextEditingController();

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
                Row(
                  children: [
                    Checkbox(
                        value: cbAnnoying,
                        onChanged: (_) => setState(() {
                              cbAnnoying = !cbAnnoying;
                            })),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text('This tutor annoying me')
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: cbFake,
                        onChanged: (_) => setState(() {
                              cbFake = !cbFake;
                            })),
                    const SizedBox(
                      width: 4,
                    ),
                    const Expanded(
                        child: Text(
                            'This profile is pretending to be someone or is fake'))
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: cvInappropriate,
                        onChanged: (_) => setState(() {
                              cvInappropriate = !cvInappropriate;
                            })),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text('Inappropriate profile photo')
                  ],
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
                          const snackBar =
                              SnackBar(content: Text('Report sent!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.of(context).pop();
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
}
