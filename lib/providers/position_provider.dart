import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';

class PositionProvider with ChangeNotifier {
  LocationAccuracy locationAccuracy;
  int distanceFilterInMeters;
  Duration? timeLimit;
  late LocationSettings _locationSettings;
  Timer? _timer;
  Position? currentPosition;
  DateTime? logTime;
  StreamSubscription<Position>? _positionStreamSubscription;

  PositionProvider({
    this.locationAccuracy = LocationAccuracy.best,
    this.distanceFilterInMeters = 5,
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
      Geolocator.openAppSettings();
      // Permissions are denied forever, handle appropriately.
      return (
        true, null,

        // false,
        // 'Location permissions are permanently denied, we cannot request permissions.'
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return (true, null);
  }

  void startTracking(void Function() callback) {
    _positionStreamSubscription?.cancel(); // Stop any existing tracking

    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: _locationSettings)
            .listen((Position position) {
      currentPosition = position;
      logTime = position.timestamp;
      debugPrint(
          "Tracking Location: ${position.latitude}, ${position.longitude}");
      callback();
      notifyListeners();
    });

    FlutterBackgroundService().invoke("startTracking");
  }

  void stopTracking() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
    FlutterBackgroundService().invoke("stopTracking");
    debugPrint('Tracking stopped.');
  }

  bool get isTracking {
    return _timer != null && _timer!.isActive;
  }
}
