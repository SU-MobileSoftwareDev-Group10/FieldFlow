import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PositionProvider with ChangeNotifier {
  LocationAccuracy locationAccuracy;
  int distanceFilterInMeters;
  Duration? timeLimit;
  late LocationSettings _locationSettings;
  Timer? _timer;
  Position? currentPosition;

  PositionProvider({
    this.locationAccuracy = LocationAccuracy.best,
    this.distanceFilterInMeters = 1,
    this.timeLimit,
  }) {
    _locationSettings = LocationSettings(
        accuracy: locationAccuracy,
        distanceFilter: distanceFilterInMeters,
        timeLimit: timeLimit);
  }

  Future<(bool, String?)> get canTrackPosition async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return (false, 'Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return (false, 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return (
        false,
        'Location permissions are permanently denied, we cannot request permissions.'
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return (true, null);
  }

  void startTracking(
    void Function() callback, {
    Duration every = const Duration(seconds: 5),
  }) {
    func(_) async {
      currentPosition = await Geolocator.getCurrentPosition(
          locationSettings: _locationSettings);
      callback();
      notifyListeners();
    }
    
    func(null);

    _timer = Timer.periodic(every, func);
  }

  void stopTracking() {
    print('Stopping tracking...');
    _timer?.cancel();
    _timer = null;
    print('Tracking stopped.');
  }

  bool get isTracking {
    return _timer != null && _timer!.isActive;
  }
}
