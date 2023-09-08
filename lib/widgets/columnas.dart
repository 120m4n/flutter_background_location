import 'package:flutter/material.dart';
import 'package:flutter_background_location/widgets/btn_custom.dart';

class MyWidgetColumns extends StatelessWidget {
  const MyWidgetColumns({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      verticalDirection: VerticalDirection.down,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 35), // Space of 35 pixels
        MyButton(Colors.orange, 1, 150, 35),
        MyButton(Colors.blue, 2, 150, 35),
        MyButton(Colors.red, 3, 150, 35),
      ],
    );
  }
}
