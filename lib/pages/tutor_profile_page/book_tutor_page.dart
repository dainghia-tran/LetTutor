import 'package:flutter/material.dart';
import 'package:lettutor/pages/tutor_profile_page/widgets/book_schedule_dialog.dart';
import 'package:lettutor/widgets/button/primary_button_rounded.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'book_tutor_provider.dart';

class BookTutorPage extends StatefulWidget {
  const BookTutorPage({Key? key, required this.tutorId}) : super(key: key);
  final String tutorId;
  @override
  _BookTutorPageState createState() => _BookTutorPageState();
}

class _BookTutorPageState extends State<BookTutorPage> {
  final BookTutorProvider _bookTutorProvider = BookTutorProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _bookTutorProvider.getTutorSchedule(widget.tutorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _bookTutorProvider,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Book lesson',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Consumer<BookTutorProvider>(builder: (_, prov, __) {
          return SizedBox(
            child: !prov.isLoading
                ? SfCalendar(
                    cellBorderColor: Colors.black,
                    view: CalendarView.day,
                    showDatePickerButton: true,
                    showCurrentTimeIndicator: false,
                    dataSource: prov.appointmentData,
                    allowAppointmentResize: true,
                    appointmentBuilder: (context, calendarAppointmentDetails) {
                      var appointment =
                          calendarAppointmentDetails.appointments.first;
                      if (appointment.subject == 'Booked') {
                        return const Center(
                          child: Text(
                            'Booked',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        );
                      } else {
                        return Center(
                          child: PrimaryButtonRounded(
                            width: 100,
                            height: 50,
                            isDisabled: false,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => BookScheduleDialog(
                                  data: appointment,
                                ),
                              ).then((value) async {
                                if (value != null) {
                                  prov.getTutorSchedule(widget.tutorId);
                                  prov.getCalendarTiles();
                                }
                              });
                            },
                            text: appointment.subject,
                          ),
                        );
                      }
                    },
                    timeSlotViewSettings: const TimeSlotViewSettings(
                      startHour: 0,
                      endHour: 23,
                      timeIntervalHeight: 65,
                      timeRulerSize: 120,
                      timeTextStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      timeInterval: Duration(
                        minutes: 25,
                      ),
                      timeFormat: "HH:mm",
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
          );
        }),
      ),
    );
  }
}
