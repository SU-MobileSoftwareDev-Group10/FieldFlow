import 'package:field_flow/homepage/check_in_out_button.dart';
import 'package:flutter/material.dart';
import 'package:field_flow/banner.dart';
import 'package:field_flow/mixins/dialog_confirm.dart';
import 'package:field_flow/providers/position_provider.dart';
import 'package:field_flow/providers/time_tracker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class CheckInOut extends StatefulWidget {
  const CheckInOut({super.key});

  @override
  State<CheckInOut> createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> with DialogConfirmMixin {
  List<(Position, DateTime)> rawPositions = [];

  @override
  Widget build(BuildContext context) {
    final timeTracker = context.watch<TimeTracker>();
    final positionProvider = context.watch<PositionProvider>();

    void positionListener() async {
      final currentPosition = positionProvider.currentPosition;
      final currentTime = DateTime.now();
      rawPositions.add((currentPosition!, currentTime));
      debugPrint('position: ${currentPosition.toString()} at $currentTime');
    }

    void resetCheckOut() {}

    checkIn() async {
      final (canTrackPosition, error) = await positionProvider.canTrackPosition;
      if (canTrackPosition) {
        positionProvider.startTracking(positionListener);
        timeTracker.checkIn();
        FieldFlowBanner.show(context, 'Tracking Location');
      } else {
        debugPrint(error);
        FieldFlowBanner.handleLocationDenied(context, error!);
      }
    }

    checkOut() async {
      bool confirmed =
          await showConfirmDialog(context: context, title: 'Check Out?');
      if (confirmed) {
        positionProvider.stopTracking();
        timeTracker.checkOut(rawPositions);
        setState(() {
          FieldFlowBanner.hide(context);
          resetCheckOut();
        });
      }
    }

    return CheckInOutButton(
      checkIn,
      checkOut,
    );
  }
}
