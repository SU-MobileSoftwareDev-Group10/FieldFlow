import 'package:field_flow/providers/time_tracker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckInOutButton extends StatelessWidget {
  final VoidCallback checkIn;
  final VoidCallback checkOut;

  const CheckInOutButton(this.checkIn, this.checkOut, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final timeTracker = context.watch<TimeTracker>();

    return ElevatedButton(
      onPressed: switch (timeTracker.checkedIn) {
        true => checkOut,
        false => checkIn,
      },
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(50),
          backgroundColor: Colors.lightBlueAccent),
      child: Text(
        timeTracker.checkedIn ? 'Check Out' : 'Check In',
      ),
    );
  }
}