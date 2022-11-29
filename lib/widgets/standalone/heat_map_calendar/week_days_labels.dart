import 'package:cabin_booking/utils/num_extension.dart';
import 'package:flutter/material.dart';

import 'utils/time.dart';

class WeekDaysLabels extends StatelessWidget {
  final double squareSize;
  final int firstWeekDay;
  final double space;

  const WeekDaysLabels({
    super.key,
    required this.squareSize,
    this.firstWeekDay = DateTime.sunday,
    this.space = 4,
  }) : assert(squareSize > 0, 'squareSize must be greater than zero.');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: squareSize),
        for (var i = 0; i < DateTime.daysPerWeek; i++)
          if (i.isOdd)
            Container(
              height: squareSize + space,
              padding: EdgeInsetsDirectional.only(end: space),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                weekDaysLabels[i.weekdayMod(firstWeekDay - 1).toInt()],
                style: Theme.of(context).textTheme.caption,
              ),
            )
          else
            SizedBox(height: squareSize + space),
      ],
    );
  }
}
