import 'package:flutter/material.dart';

class LogItem extends StatelessWidget {
  const LogItem({Key? key, required this.locationLabel, required this.index}) : super(key: key);

  final int index;
  final String locationLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('<${index + 1}>  $locationLabel', style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 20),
      ],
    );
  }
}