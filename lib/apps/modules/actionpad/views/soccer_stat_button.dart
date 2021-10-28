import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as _math;

typedef SoccerstatCallback = void Function(String actionPushed );

class SoccerstatbuttonView extends StatelessWidget {
  final int delay; //in microseconds
  final double size;
  final String singleTapAction;
  String doubleTapAction;
  String longTapAction;
  final Color backgroundColor;
  final Color padColor;
  final double opacity;
  final String assetLink;
  final SoccerstatCallback onStatButtonPushed;
  String lastAction;

  SoccerstatbuttonView({
    required this.onStatButtonPushed,
    required this.size,
    required this.singleTapAction,
    required this.assetLink,
    this.backgroundColor = Colors.blueGrey,
    this.padColor = Colors.blueGrey,
    this.opacity = 1.0,
    this.delay = 100,
    this.lastAction = "None",
    this.doubleTapAction = "",
    this.longTapAction = ""
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
    if (doubleTapAction == "") {
      doubleTapAction = singleTapAction;
    }
    if (longTapAction == "") {
      longTapAction = singleTapAction;
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
                    "Soccerstatbutton ${singleTapAction} onTapDown, image reduced from ${unpressedSize} to ${buttonSize}");
              },
              onTapUp: (details) {
                setState(() => buttonSize = pressedSize);

                print(
                    "Soccerstatbutton ${singleTapAction} onTapUp localposition : dx: ${details.localPosition.dx}  dy: ${details.localPosition.dy}");
                print(
                    "                       onTapUp globalposition : dx: ${details.globalPosition.dx}  dy: ${details.globalPosition.dy}");
              },
              onTap: () {
                setState(() => {
                  buttonSize = unpressedSize,
                  onStatButtonPushed(singleTapAction)}
                );
                HapticFeedback.mediumImpact();
                print(
                    "Soccerstatbutton ${singleTapAction} onTap, image returned to ${buttonSize}");
              },
              onTapCancel: () {
                setState(() => buttonSize = unpressedSize);
                HapticFeedback.mediumImpact();
                print(
                    "Soccerstatbutton ${singleTapAction} onTapCancel, image returned to ${buttonSize}");
              },
              onDoubleTapDown: (details) {
                setState(() => buttonSize = pressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${doubleTapAction} onDoubleTapDown");

              },
              onDoubleTap: () {
                HapticFeedback.mediumImpact();
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${doubleTapAction} onDoubleTap");
                setState(() => {buttonSize = unpressedSize, onStatButtonPushed(doubleTapAction)});
              },
              onDoubleTapCancel: () {
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${singleTapAction} onDoubleTapCancel");
                setState(() => buttonSize = unpressedSize);
              },
              onLongPressStart: (details) {
                setState(() => buttonSize = pressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${longTapAction} onLongPressStart");
              },
              onLongPressDown: (details) {
                setState(() => buttonSize = pressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${longTapAction} onLongPressDown");
              },
              onLongPressEnd: (details) {
                setState(() => buttonSize = pressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${longTapAction} onLongPressEnd");
              },
              onLongPressUp: () {
                setState(() => buttonSize = unpressedSize);
                onStatButtonPushed(longTapAction);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${longTapAction} onLongPressUp");
              },
              onLongPressCancel: () {
                setState(() => buttonSize = unpressedSize);
                HapticFeedback.mediumImpact();
                print("Soccerstatbutton ${singleTapAction} onLongPressCancel");
              },
            );
          },
        ));
  }
}
