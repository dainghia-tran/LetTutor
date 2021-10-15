import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';

class BookScheduleDialog extends StatelessWidget {
  const BookScheduleDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Booking details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    'Booking Time',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xffeeeaff),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  '06:30 - 06:55 Saturday, 16 October 2021',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff7766c7),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(7),
                      },
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
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    'Balance',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    'You have 0 lesson left',
                                    style: TextStyle(
                                      color: Color(0xff7766c7),
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        TableRow(
                          decoration: const BoxDecoration(
                            color: Color(0xfff0f0f0),
                          ),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    'Price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    '1 lesson',
                                    style: TextStyle(
                                      color: Color(0xff7766c7),
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
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
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Text(
                                    'Notes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(16),
                                child: TextFormField(
                                  onTap: (){
                                    _controller.jumpTo(_controller.position.maxScrollExtent);
                                  },
                                  minLines: 5,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                )),
                          ],
                        )
                      ],
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
                        SecondaryButton(
                          isDisabled: true,
                          onPressed: () {},
                          text: 'Book',
                          icon: Icons.double_arrow,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
