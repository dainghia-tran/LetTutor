import 'package:flutter/material.dart';
import 'package:lettutor/pages/booking_history_page/booking_history_provider.dart';
import 'package:lettutor/pages/booking_history_page/widgets/booking_history_item.dart';
import 'package:lettutor/widgets/button/secondary_button.dart';
import 'package:provider/provider.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  final BookingHistoryProvider _bookingHistoryProvider =
      BookingHistoryProvider();

  @override
  void initState() {
    super.initState();
    _bookingHistoryProvider.getSchedules(true);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _bookingHistoryProvider,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Booking history',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer<BookingHistoryProvider>(
                builder: (_, prov, __) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: prov.scheduleList.isNotEmpty
                            ? ListView(
                                shrinkWrap: true,
                                primary: false,
                                children: prov.scheduleList
                                    .map((e) => BookingHistoryItem(schedule: e))
                                    .toList(),
                              )
                            : (!prov.isLoading)
                                ? const Center(
                                    child: Text(
                                      "No data",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Container(),
                      ),
                      if (prov.page * prov.perPage < prov.count &&
                          prov.isLoading == false)
                        SecondaryButton(
                          isDisabled: false,
                          text: "Load more",
                          width: 120,
                          onPressed: () async {
                            prov.page += 1;
                            await prov.getSchedules(false);
                          },
                        ),
                      if (prov.isLoading == true)
                        prov.scheduleList.isEmpty
                            ? const Expanded(
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : const Center(child: CircularProgressIndicator())
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
