import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as _math;

typedef SoccerstatCallback = void Function(String actionPushed );

class SoccerstatbuttonView extends StatelessWidget {
  final int delay; //in microseconds
  final double size;
  final String actionName;
  final Color backgroundColor;
  final Color padColor;
  final double opacity;
  final String assetLink;
  final SoccerstatCallback onStatButtonPushed;
  String lastAction;

  SoccerstatbuttonView({
    required this.onStatButtonPushed,
    required this.size,
    required this.actionName,
    required this.assetLink,
    this.backgroundColor = Colors.blueGrey,
    this.padColor = Colors.blueGrey,
    this.opacity = 1.0,
    this.delay = 100,
    this.lastAction = "None"
  });


  @override
  Widget build(BuildContext context) {
    double unpressedSize = 10.0;
    if ((size - 1) > 10) {
      unpressedSize = (size - 1);
    }
    double pressedSize = 6.0;
    if ((size - 10) > 6) {
      pressedSize = (size - 10);
    }

    double buttonSize = unpressedSize;

    return Container(
        width: unpressedSize + 1,
        height: unpressedSize + 1,
        child: StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              child: Center(
                child: SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: Image.asset(assetLink),
                ),
              ),
              onTapDown: (details) {
                setState(() => buttonSize = pressedSize);
                HapticFeedback.mediumImpact();
                print(
                    "Soccerstatbutton ${actionName} onTapDown, image reduced from ${unpressedSize} to ${buttonSize}");
              },
              onTapUp: (details) {
                setState(() => buttonSize = pressedSize);

                print(
                    "Soccerstatbutton ${actionName} onTapUp localposition : dx: ${details.localPosition.dx}  dy: ${details.localPosition.dy}");
                print(
                    "                       onTapUp globalposition : dx: ${details.globalPosition.dx}  dy: ${details.globalPosition.dy}");
              },
              onTap: () {
                setState(() => {
                  buttonSize = unpressedSize,
                  onStatButtonPushed(actionName)}
                );
                HapticFeedback.mediumImpact();
                print(
                    "Soccerstatbutton ${actionName} onTap, image returned to ${buttonSize}");
              },
              onTapCancel: () {
                setState(() => buttonSize = unpressedSize);
                HapticFeedback.mediumImpact();
                print(
                    "Soccerstatbutton ${actionName} onTapCancel, image returned to ${buttonSize}");
              },
              onDoubleTapDown: (details) {
                setState(() => buttonSize = pressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${actionName} onDoubleTapDown");

              },
              onDoubleTap: () {
                HapticFeedback.mediumImpact();
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${actionName} onDoubleTap");
                setState(() => {buttonSize = unpressedSize, onStatButtonPushed(actionName)});
              },
              onDoubleTapCancel: () {
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${actionName} onDoubleTapCancel");
                setState(() => buttonSize = unpressedSize);
              },
              onLongPressStart: (details) {
                setState(() => buttonSize = pressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${actionName} onLongPressStart");
              },
              onLongPressDown: (details) {
                setState(() => buttonSize = pressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${actionName} onLongPressDown");
              },
              onLongPressEnd: (details) {
                setState(() => buttonSize = pressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${actionName} onLongPressEnd");
              },
              onLongPressUp: () {
                setState(() => buttonSize = unpressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${actionName} onLongPressUp");
              },
              onLongPressCancel: () {
                setState(() => buttonSize = unpressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${actionName} onLongPressCancel");
              },
            );
          },
        ));
  }
}
