import 'package:flutter/material.dart';
import 'dart:math' as _math;
import 'package:flutter/services.dart';

typedef ActionpadCallback = void Function(
    double degrees, double distance);

class ActionpadLargeView extends StatelessWidget{
  final double size;
  final Color backgroundColor;
  final Color padColor;
  final double opacity;
  String _image1 = "assets/images/double_tl_100.png";
  String _image2 = "assets/images/double_t_100.png";
  String _image3 = "assets/images/double_tr_100.png";
  String _image4 = "assets/images/arrow_tl_100.png";
  String _image5 = "assets/images/arrow_t_100.png";
  String _image6 = "assets/images/arrow_tr_100.png";
  String _image7 = "assets/images/double_l_100.png";
  String _image8 = "assets/images/arrow_l_100.png";
  String _image9 = "assets/images/circle_100.png";
  String _image10 = "assets/images/arrow_r_100.png";
  String _image11 = "assets/images/double_r_100.png";
  String _image12 = "assets/images/arrow_bl_100.png";
  String _image13 = "assets/images/arrow_b_100.png";
  String _image14 = "assets/images/arrow_br_100.png";
  String _image15 = "assets/images/double_bl_100.png";
  String _image16 = "assets/images/double_b_100.png";
  String _image17 = "assets/images/double_br_100.png";
  String _image1_pressed = "assets/images/double_tl_80.png";
  String _image2_pressed = "assets/images/double_t_80.png";
  String _image3_pressed = "assets/images/double_tr_80.png";
  String _image4_pressed = "assets/images/arrow_tl_80.png";
  String _image5_pressed = "assets/images/arrow_t_80.png";
  String _image6_pressed = "assets/images/arrow_tr_80.png";
  String _image7_pressed = "assets/images/double_l_80.png";
  String _image8_pressed = "assets/images/arrow_l_80.png";
  String _image9_pressed = "assets/images/circle_80.png";
  String _image10_pressed = "assets/images/arrow_r_80.png";
  String _image11_pressed = "assets/images/double_r_80.png";
  String _image12_pressed = "assets/images/arrow_bl_80.png";
  String _image13_pressed = "assets/images/arrow_b_80.png";
  String _image14_pressed = "assets/images/arrow_br_80.png";
  String _image15_pressed = "assets/images/double_bl_80.png";
  String _image16_pressed = "assets/images/double_b_80.png";
  String _image17_pressed = "assets/images/double_br_80.png";

  ActionpadLargeView({
    required this.size,
    this.backgroundColor = Colors.blueGrey,
    this.padColor = Colors.blueGrey,
    this.opacity = 0.5
  }); //create constructor

  void buttonSingleTap() {
    print("ActionPad button tapped");
  }

  void buttonTapWithName(String name) {
    HapticFeedback.mediumImpact();
    print("[buttonTapWithName]:ActionPad button ${name} tapped");
  }

  void buttonDoubleTap() {
    print("ActionPad button double tap");
  }

  void buttonLongPressed() {
    print("ActionPad button tapped");
  }

  @override
  Widget build(BuildContext context) {
    String imageOutterTopLeft = _image1;
    String imageOutterTop = _image2;
    String imageOutterTopRight = _image3;
    String imageTopLeft = _image4;
    String imageTop = _image5;
    String imageTopRight = _image6;
    String imageOutterLeft = _image7;
    String imageLeft = _image8;
    String imageCenter = _image9;
    String imageRight = _image10;
    String imageOutterRight = _image11;
    String imageBottomLeft = _image12;
    String imageBottom = _image13;
    String imageBottomRight = _image14;
    String imageOutterBottomLeft = _image15;
    String imageOutterBottom = _image16;
    String imageOutterBottomRight = _image17;


    String lastAction = "";
    String buttonTapped = "";
    double calcSideSize = _math.min(MediaQuery.of(context).size.width/2, MediaQuery.of(context).size.height/2);
    double sideSize = _math.min(calcSideSize, size);
    double buttonSideSize = sideSize/5.toInt() - 1;
    return Center(
      child: StatefulBuilder(
        builder: (context, setState) {
          Widget actionpad = Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: sideSize,
                height: sideSize,
                decoration: BoxDecoration (
                  border: Border.all(color: Colors.red),
                ),
                child: Column (
                  children: <Widget>[
                    Row (
                      children: <Widget> [
                        GestureDetector(
                          onTap: () => {buttonTapWithName("Outter Top Left")},
                          onTapDown: (details) => {
                            setState(() {
                              imageOutterTopLeft = _image1_pressed;
                            })
                          },
                          onTapUp: (details) => {
                            setState(() {
                              imageOutterTopLeft  = _image1;
                            })
                          },
                          child: SizedBox(
                            width: buttonSideSize,
                            height: buttonSideSize,
                            child: Image.asset(imageOutterTopLeft),
                          ),
                        ),
                        SizedBox(
                          width: buttonSideSize,
                          height: buttonSideSize,
                        ),
                        GestureDetector(
                          onTap: () => {buttonTapWithName("Outter Top")},
                          onTapDown: (details) => {
                            setState(() {
                              imageOutterTop = _image2_pressed;
                            })
                          },
                          onTapUp: (details) => {
                            setState(() {
                              imageOutterTop  = _image2;
                            })
                          },
                          child: SizedBox(
                            width: buttonSideSize,
                            height: buttonSideSize,
                            child: Image.asset(imageOutterTop),
                          ),
                        ),
                        SizedBox(
                          width: buttonSideSize,
                          height: buttonSideSize,
                        ),
                        GestureDetector(
                          onTap: () => {buttonTapWithName("Outter Top Right")},
                          onTapDown: (details) => {
                            setState(() {
                              imageOutterTopRight = _image3_pressed;
                            })
                          },
                          onTapUp: (details) => {
                            setState(() {
                              imageOutterTopRight  = _image3;
                            })
                          },
                          child: SizedBox(
                            width: buttonSideSize,
                            height: buttonSideSize,
                            child: Image.asset(imageOutterTopRight),
                          ),
                        ),
                      ]
                    ),
                    Row (
                        children: <Widget> [
                          SizedBox(
                            width: buttonSideSize,
                            height: buttonSideSize,
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Top Left")},
                            onTapDown: (details) => {
                              setState(() {
                                imageTopLeft = _image4_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageTopLeft  = _image4;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageTopLeft),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Top")},
                            onTapDown: (details) => {
                              setState(() {
                                imageTop = _image5_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageTop  = _image5;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageTop),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Top Right")},
                            onTapDown: (details) => {
                              setState(() {
                                imageTopRight = _image6_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageTopRight  = _image6;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageTopRight),
                            ),
                          ),
                          SizedBox(
                            width: buttonSideSize,
                            height: buttonSideSize,
                          ),
                        ]
                    ),
                    Row (
                        children: <Widget> [
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Outter Left")},
                            onTapDown: (details) => {
                              setState(() {
                                imageOutterLeft = _image7_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageOutterLeft  = _image7;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageOutterLeft),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Left")},
                            onTapDown: (details) => {
                              setState(() {
                                imageLeft = _image8_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageLeft  = _image8;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageLeft),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Center")},
                            onDoubleTap: () => {buttonTapWithName("DoubleTap Center")},
                            onTapDown: (details) => {
                              setState(() {
                                imageCenter = _image9_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageCenter  = _image9;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageCenter),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Right")},
                            onTapDown: (details) => {
                              setState(() {
                                imageRight = _image10_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageRight  = _image10;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageRight),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Outter Right")},
                            onTapDown: (details) => {
                              setState(() {
                                imageOutterRight = _image11_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageOutterRight  = _image11;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageOutterRight),
                            ),
                          ),
                        ]
                    ),
                    Row (
                        children: <Widget> [
                          SizedBox(
                            width: buttonSideSize,
                            height: buttonSideSize,
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Bottom Left")},
                            onTapDown: (details) => {
                              setState(() {
                                imageBottomLeft = _image12_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageBottomLeft  = _image12;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageBottomLeft),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Bottom")},
                            onTapDown: (details) => {
                              setState(() {
                                imageBottom = _image13_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageBottom  = _image13;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageBottom),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Bottom Right")},
                            onTapDown: (details) => {
                              setState(() {
                                imageBottomRight = _image14_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageBottomRight  = _image14;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageBottomRight),
                            ),
                          ),
                          SizedBox(
                            width: buttonSideSize,
                            height: buttonSideSize,
                          ),
                        ]
                    ),
                    Row (
                        children: <Widget> [
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Outter Bottom Left")},
                            onTapDown: (details) => {
                              setState(() {
                                imageOutterBottomLeft = _image15_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageOutterBottomLeft  = _image15;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageOutterBottomLeft),
                            ),
                          ),
                          SizedBox(
                            width: buttonSideSize,
                            height: buttonSideSize,
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Outter Bottom")},
                            onTapDown: (details) => {
                              setState(() {
                                imageOutterBottom = _image16_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageOutterBottom  = _image16;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageOutterBottom),
                            ),
                          ),
                          SizedBox(
                            width: buttonSideSize,
                            height: buttonSideSize,
                          ),
                          GestureDetector(
                            onTap: () => {buttonTapWithName("Outter Bottom Right")},
                            onTapDown: (details) => {
                              setState(() {
                                imageOutterBottomRight = _image17_pressed;
                              })
                            },
                            onTapUp: (details) => {
                              setState(() {
                                imageOutterBottomRight  = _image17;
                              })
                            },
                            child: SizedBox(
                              width: buttonSideSize,
                              height: buttonSideSize,
                              child: Image.asset(imageOutterBottomRight),
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
              ),
            ],
          );
          return GestureDetector(
            onTap: () {
              print("ActionPad tap");
              setState(() => lastAction = "Single Tap");
            },
            onTapUp: (details) {
              print("ActionPad onTapUp : dx: ${details.localPosition.dx}  dy: ${details.localPosition.dy}");
              print("          onTapUp : dx: ${details.globalPosition.dx}  dy: ${details.globalPosition.dy}");
              setState(() => lastAction = "Single Tap");
            },
            onDoubleTap: () {
              print("ActionPad double tap");
              setState(() => lastAction = "Double Tap");
            },
            child: (opacity != null) ? Opacity(opacity: opacity, child: actionpad) : actionpad,
          );
        },
      ),
    );
  }


}