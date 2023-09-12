import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String? bgImagePath;
  final Color? bgColor;

  const Background(
      {super.key, required this.child, this.bgImagePath, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
            child: Container(
          color: bgColor ?? Theme.of(context).colorScheme.surface,
        )),
        if (bgImagePath != null)
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bgImagePath!), fit: BoxFit.cover)),
              ),
            ),
          ),
        Positioned.fill(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: child
            );
            }
          )
        )
      ],
    );
  }
}
