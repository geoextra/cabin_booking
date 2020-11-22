import 'package:cabin_booking/constants.dart';
import 'package:cabin_booking/l10n/app_localizations.dart';
import 'package:cabin_booking/model/booking.dart';
import 'package:cabin_booking/model/cabin.dart';
import 'package:cabin_booking/model/recurring_booking.dart';
import 'package:cabin_booking/widgets/booking/booking_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timer_builder/timer_builder.dart';

class BookingCard extends StatelessWidget {
  final Cabin cabin;
  final Booking booking;

  BookingCard({@required this.cabin, @required this.booking});

  @override
  Widget build(BuildContext context) {
    final _height = booking.duration.inMinutes * bookingHeightRatio - 16.0;

    return booking.isDisabled
        ? Container(
            margin: const EdgeInsets.all(8.0),
            child: Tooltip(
              message: '${booking.studentName} '
                  '(${AppLocalizations.of(context).disabled.toLowerCase()})',
              child: InkWell(
                onTap: () {},
                mouseCursor: MouseCursor.defer,
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Container(
                  height: _height,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(child: SizedBox()),
                      BookingPopupMenu(
                        cabin: cabin,
                        booking: booking,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : TimerBuilder.periodic(
            Duration(minutes: 1),
            builder: (context) {
              final _isBeforeNow = booking.dateEnd.isBefore(DateTime.now());

              return Card(
                margin: const EdgeInsets.all(8.0),
                shadowColor: _isBeforeNow ? Colors.black38 : Colors.black,
                color: Colors.transparent,
                child: Container(
                  height: _height,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: booking is RecurringBooking ||
                            booking.recurringBookingId != null
                        ? Colors.blue[50]
                        : _isBeforeNow
                            ? const Color.fromARGB(150, 255, 255, 255)
                            : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(booking.studentName),
                            Text(
                              booking.timeRange,
                              style: const TextStyle(color: Colors.black38),
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
