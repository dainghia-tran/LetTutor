import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/app_provider.dart';
import 'package:lettutor/constants/http.dart';
import 'package:lettutor/models/price.dart';
import 'package:lettutor/models/user.dart';
import 'package:lettutor/widgets/button/primary_button.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';

class BookScheduleDialog extends StatefulWidget {
  const BookScheduleDialog({Key? key, required this.data}) : super(key: key);

  final dynamic data;

  @override
  State<BookScheduleDialog> createState() => _BookScheduleDialogState();
}

class _BookScheduleDialogState extends State<BookScheduleDialog> {
  User user = User();
  bool isLoading = true;
  bool priceLoading = true;
  Price price = Price();
  final TextEditingController _noteController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    getUserInfo();
    getPriceEach();
  }

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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xffeeeaff),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  DateFormat('hh:mm')
                                          .format(widget.data.startTime) +
                                      '-' +
                                      DateFormat(
                                        'hh:mm EEEE, dd MMMM y',
                                      ).format(widget.data.endTime),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
                                  child: Text(
                                    'You have ${((int.tryParse(user.walletInfo?.amount ?? "0") ?? 0) ~/ 100000)} lesson left',
                                    style: const TextStyle(
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
                                  child: Text(
                                    '${((int.tryParse(price.price ?? "0") ?? 0) ~/ 100000)} lesson',
                                    style: const TextStyle(
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
                                onTap: () {
                                  _controller.jumpTo(
                                      _controller.position.maxScrollExtent);
                                },
                                controller: _noteController,
                                minLines: 5,
                                maxLines: 5,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
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
                        PrimaryButton(
                          isDisabled: ((int.tryParse(price.price ?? '0') ?? 0) /
                                  100000) >
                              (int.tryParse(user.walletInfo?.amount ?? '0') ??
                                  0),
                          onPressed: () async {
                            final result = await bookClass();
                            if (result != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    result,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Booking class successfully',
                                  ),
                                ),
                              );
                              Navigator.pop(context, true);
                            }
                          },
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

  Future<void> getUserInfo() async {
    try {
      setState(() {
        isLoading = true;
      });
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.get("user/info");
      User result = User.fromJson(res.data["user"]);
      setState(() {
        user = result;
        isLoading = false;
      });
    } catch (e) {
      inspect(e);
    }
  }

  Future<void> getPriceEach() async {
    try {
      setState(() {
        priceLoading = true;
      });
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      var res = await dio.get("payment/price-of-session");
      Price result = Price.fromJson(res.data);
      setState(() {
        price = result;
        priceLoading = false;
      });
    } catch (e) {
      inspect(e);
    }
  }

  Future<String?> bookClass() async {
    try {
      var dio = Http().client;
      var accessToken = AppProvider.auth?.tokens?.access?.token;
      dio.options.headers["Authorization"] = "Bearer $accessToken";
      await dio.post(
        "booking",
        data: {
          'note': _noteController.text,
          'scheduleDetailIds[]': [widget.data.id],
        },
      );
      return null;
    } catch (e) {
      inspect(e);
      (e as DioError).response?.data["message"];
    }
  }
}
