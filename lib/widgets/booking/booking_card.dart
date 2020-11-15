import 'package:cabin_booking/constants.dart';
import 'package:cabin_booking/model/booking.dart';
import 'package:cabin_booking/model/cabin.dart';
import 'package:cabin_booking/widgets/booking/booking_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class BookingCard extends StatelessWidget {
  final Cabin cabin;
  final Booking booking;

  BookingCard({@required this.cabin, @required this.booking});

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(
      Duration(minutes: 1),
      builder: (context) {
        return Card(
          margin: const EdgeInsets.all(8),
          color: booking.dateEnd.isBefore(DateTime.now())
              ? Colors.grey[200]
              : null,
          child: Container(
            height: booking.duration.inMinutes * bookingHeightRatio - 16,
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking.studentName),
                      Text(
                        booking.dateRange,
                        style: TextStyle(color: Colors.black38),
                      ),
                    ],
                  ),
                ),
                BookingPopupMenu(
                  cabin: cabin,
                  booking: booking,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
