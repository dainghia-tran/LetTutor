import 'package:flutter/material.dart';
import 'package:lettutor/widgets/booking_history_item.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Column(
            children: const [
              BookingHistoryItem(tutorName: 'Tran Nghia', time: '20:25 - 23/10/2021', requires: 'Nothing but a computer, papers and a pen. Dont forget to take a rest before lesson begin, it will be a long lesson.',),
              SizedBox(height: 8,),
              BookingHistoryItem(tutorName: 'Tran Nghia', time: '20:25 - 22/10/2021', requires: 'Nothing but a computer, papers and a pen.',),
              SizedBox(height: 8,),
              BookingHistoryItem(tutorName: 'Tran Nghia', time: '20:25 - 21/10/2021',)
            ],
          ),
        ),
      ),
    );
  }
}
