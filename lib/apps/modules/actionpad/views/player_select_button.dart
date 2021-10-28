import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as _math;

typedef PlayerSelectCallback = void Function(String actionPushed);

class PlayerSelectButtonView extends StatelessWidget {
  final int delay; //in microseconds
  final double width;
  final double height;
  final String playerName;
  final Color backgroundColor;
  final Color buttonColor;
  final double opacity;
  final String assetLink;
  final PlayerSelectCallback onPlayerSelectButtonPushed;
  String lastAction;
  bool isActive;

  PlayerSelectButtonView(
      {required this.onPlayerSelectButtonPushed,
      required this.width,
      required this.height,
      required this.playerName,
      required this.assetLink,
      this.backgroundColor = Colors.blueGrey,
      this.buttonColor = Colors.blueGrey,
      this.opacity = 1.0,
      this.delay = 100,
      this.lastAction = "None",
      this.isActive = true});

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;

    double unpressedWidth = 10.0;
    if ((width - 1) > 10) {
      unpressedWidth = (width - 1);
    }
    double pressedWidth = 6.0;
    if ((width - 10) > 6) {
      pressedWidth = (width - 10);
    }

    double unpressedHeight = 10.0;
    if ((height - 1) > 10) {
      unpressedHeight = (height - 1);
    }
    double pressedHeight = 6.0;
    if ((height - 10) > 6) {
      pressedHeight = (height - 10);
    }
    double buttonWidth = unpressedWidth;
    double buttonHeight = unpressedHeight;

    return Container(
        width: unpressedWidth - 1,
        height: unpressedHeight - 1,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: isActive ? buttonColor : Colors.black38),
        child: StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              child: Center(
                child: SizedBox(
                  width: isPressed ? pressedWidth - 2 : unpressedWidth - 2,
                  height: isPressed ? pressedHeight - 2 : unpressedHeight - 2,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: isActive ? buttonColor:Colors.black12),
                      child: Row(children: [
                        Image.asset(assetLink),
                        Text(playerName)
                      ])),
                ),
              ),
              onTapDown: (details) {
                if (isActive) {
                  setState(() => {isPressed = true});
                  HapticFeedback.mediumImpact();
                  print(
                      "PlayerSelectionbutton ${playerName} onTapDown, image reduced from ${unpressedWidth} to ${buttonWidth}");
                }
              },
              onTapUp: (details) {
                if (isActive) {
                  setState(() => {
                        buttonWidth = pressedWidth,
                        buttonHeight = pressedHeight
                      });

                  print(
                      "PlayerSelectionbutton ${playerName} onTapUp localposition : dx: ${details.localPosition.dx}  dy: ${details.localPosition.dy}");
                  print(
                      "                       onTapUp globalposition : dx: ${details.globalPosition.dx}  dy: ${details.globalPosition.dy}");
                }
              },
              onTap: () {
                if (isActive) {
                  setState(() => {
                        buttonWidth = unpressedWidth,
                        buttonHeight = unpressedHeight,
                        onPlayerSelectButtonPushed(playerName)
                      });
                  HapticFeedback.mediumImpact();
                  print(
                      "PlayerSelectionbutton ${playerName} onTap, image returned to ${buttonWidth}");
                }
              },
              onTapCancel: () {
                if (isActive) {
                  setState(() => {
                        buttonWidth = unpressedWidth,
                        buttonHeight = unpressedHeight
                      });
                  HapticFeedback.mediumImpact();
                  print(
                      "PlayerSelectionbutton ${playerName} onTapCancel, image returned to ${buttonWidth}");
                }
              },
              onDoubleTapDown: (details) {
                if (isActive) {
                  setState(() => {
                        buttonWidth = pressedWidth,
                        buttonHeight = pressedHeight
                      });
                  HapticFeedback.mediumImpact();
                  print("PlayerSelectionbutton ${playerName} onDoubleTapDown");
                }
              },
              onDoubleTap: () {
                if (isActive) {
                  HapticFeedback.mediumImpact();
                  HapticFeedback.mediumImpact();
                  print("PlayerSelectionbutton ${playerName} onDoubleTap");
                  setState(() => {
                        buttonWidth = unpressedWidth,
                        buttonHeight = unpressedHeight,
                        onPlayerSelectButtonPushed(playerName)
                      });
                }
              },
              onDoubleTapCancel: () {
                if (isActive) {
                  HapticFeedback.mediumImpact();
                  print(
                      "PlayerSelectionbutton ${playerName} onDoubleTapCancel");
                  setState(() => {
                        buttonWidth = unpressedWidth,
                        buttonHeight = unpressedHeight
                      });
                }
              },
              onLongPressStart: (details) {
                if (isActive) {
                  setState(() => {
                        buttonWidth = pressedWidth,
                        buttonHeight = pressedHeight
                      });
                  HapticFeedback.mediumImpact();
                  print("PlayerSelectionbutton ${playerName} onLongPressStart");
                }
              },
              onLongPressDown: (details) {
                if (isActive) {
                  setState(() => {
                        buttonWidth = pressedWidth,
                        buttonHeight = pressedHeight
                      });
                  HapticFeedback.mediumImpact();
                  print("PlayerSelectionbutton ${playerName} onLongPressDown");
                }
              },
              onLongPressEnd: (details) {
                if (isActive) {
                  setState(() => {
                        buttonWidth = pressedWidth,
                        buttonHeight = pressedHeight
                      });
                  HapticFeedback.mediumImpact();
                  print("PlayerSelectionbutton ${playerName} onLongPressEnd");
                }
              },
              onLongPressUp: () {
                if (isActive) {
                  setState(() => {
                        buttonWidth = unpressedWidth,
                        buttonHeight = unpressedHeight
                      });
                  HapticFeedback.mediumImpact();
                  print("PlayerSelectionbutton ${playerName} onLongPressUp");
                }
              },
              onLongPressCancel: () {
                if (isActive) {
                  setState(() => {
                        buttonWidth = unpressedWidth,
                        buttonHeight = unpressedHeight
                      });
                  HapticFeedback.mediumImpact();
                  print(
                      "PlayerSelectionbutton ${playerName} onLongPressCancel");
                }
              },
            );
          },
        ));
  }
}
