import 'package:flutter/material.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FilledButton.tonal(
            onPressed: () {
              Navigator.of(context).popUntil(
                (route) {
                  return route.isFirst;
                },
              );
            },
            child: Text('Home Page')),
      ],
    );
  }
}
