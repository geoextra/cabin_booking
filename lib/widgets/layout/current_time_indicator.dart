import 'package:cabin_booking/constants.dart';
import 'package:cabin_booking/model/day_handler.dart';
import 'package:cabin_booking/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_builder/timer_builder.dart';

class CurrentTimeIndicator extends StatelessWidget {
  const CurrentTimeIndicator();

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(
      const Duration(seconds: 5),
      builder: (context) {
        final dayHandler = Provider.of<DayHandler>(context);

        final viewStartDateTime = tryParseDateTimeWithTimeOfDay(
          dateTime: dayHandler.dateTime,
          timeOfDay: timeTableStartTime,
        );

        final viewEndDateTime = tryParseDateTimeWithTimeOfDay(
          dateTime: dayHandler.dateTime,
          timeOfDay: timeTableEndTime,
        );

        final durationFromStart = DateTime.now().difference(viewStartDateTime);

        final durationFromEnd = DateTime.now().difference(viewEndDateTime);

        if (durationFromStart <= const Duration() ||
            durationFromEnd >= const Duration(minutes: 15)) {
          return const SizedBox();
        }

        return Column(
          children: [
            SizedBox(
              height: durationFromStart.inMicroseconds /
                  Duration.microsecondsPerMinute *
                  bookingHeightRatio,
              child: Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  TimeOfDay.fromDateTime(DateTime.now()).format(context),
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 2.0,
              decoration: BoxDecoration(
                color: Colors.red[400],
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                    offset: Offset(3.0, 4.0),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
