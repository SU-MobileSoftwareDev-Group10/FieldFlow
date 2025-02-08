import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class FieldFlowBanner {
  static show(BuildContext context, String text,
      [List<Widget> actions = const []]) {
    FieldFlowBanner.hide(context);
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
        actions: [
          SizedBox(), // fix error
          ...actions
        ]));
  }

  static handleLocationDenied(BuildContext context, String text) {
    FieldFlowBanner.show(context, text, [
      TextButton(
          onPressed: () => Geolocator.openAppSettings(),
          child: Text('App Settings')),
      TextButton(
          onPressed: () => Geolocator.openLocationSettings(),
          child: Text('Location Settings'))
    ]);
  }

  static hide(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
  }
}
