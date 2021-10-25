import 'package:flutter/material.dart';
import 'dart:math' as _math;
import 'package:flutter/services.dart';
import 'package:fometic_app/apps/modules/actionpad/views/soccer_stat_button.dart';

typedef ActionpadwideCallback = void Function(double degrees, double distance);

class ActionpadwideView extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Color padColor;
  final double opacity;
  String lastAction;

  ActionpadwideView(
      {required this.size,
      this.backgroundColor = Colors.blueGrey,
      this.padColor = Colors.blueGrey,
      this.opacity = 1.0,
      this.lastAction="None"}); //create constructor

  @override
  Widget build(BuildContext context) {
    String lastActionButton = "";
    String buttonTapped = "";
    double calcSideSize = _math.min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    double sideSize = _math.min(calcSideSize, size);

    double unpressedSize =
        ((sideSize / 14) - 1) > 10 ? ((sideSize / 14) - 1) : 10;
    double buttonSideSize = unpressedSize;
    double pressedSize = (unpressedSize - 5) > 6 ? (unpressedSize - 5) : 6;

    return Center(
      child: StatefulBuilder(
        builder: (context, setState) {
          Widget actionpadwide = Container(
              margin: EdgeInsets.all(2),
              width: sideSize,
              height: (buttonSideSize*8)+5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0,
                    top: 0,
                    width: sideSize / 3,
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/heading.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/shoot.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/shoot_long.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/new_player.png",
                          ),
                        ]),

                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/drible.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/pass_short.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/pass_long.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/substituted.png",
                          ),
                        ]),
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/handling.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/intercept.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/tackle_ok.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/foul.png",
                          ),
                        ]),
                        SizedBox(
                          height: buttonSideSize/2,
                        ),
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/owngoal.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/tackle_nok.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/handsball.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/offside.png",
                          ),
                        ]),
                        SizedBox(
                          height: buttonSideSize/2,
                        ),
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/offtarget.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/ontarget.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/goal.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/ballout.png",
                          ),
                        ]),
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/goal_saving.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/assist.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/penalty_shoot.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/yellowcard.png",
                          ),
                        ]),
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/offball.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/throwin.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/cornerkick.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/redcard.png",
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    width: sideSize / 3,
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/new_player.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/heading.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/shoot.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/shoot_long.png",
                          ),
                        ]),

                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/substituted.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/drible.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/pass_short.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/pass_long.png",
                          ),
                        ]),
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Foul",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/foul.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Handling",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/handling.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Intercept",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/intercept.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Good Tackle",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/tackle_ok.png",
                          ),
                        ]),
                        SizedBox(
                          height: buttonSideSize/2,
                        ),
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Offside",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/offside.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/owngoal.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/tackle_nok.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/handsball.png",
                          ),
                        ]),
                        SizedBox(
                          height: buttonSideSize/2,
                        ),
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Ballout",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/ballout.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot Off Target",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/offtarget.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/ontarget.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Goal",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/goal.png",
                          ),
                        ]),
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Yellow Card",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/yellowcard.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/goal_saving.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/assist.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/penalty_shoot.png",
                          ),
                        ]),
                        Row(children: <Widget>[
                          SoccerstatbuttonView(
                            actionName: "Red Card",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/redcard.png",
                          ),
                          SizedBox(
                            width: buttonSideSize / 2,
                            height: buttonSideSize,
                          ),
                          SoccerstatbuttonView(
                            actionName: "Heading",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/offball.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/throwin.png",
                          ),
                          SoccerstatbuttonView(
                            actionName: "Long Shoot",
                            size: buttonSideSize,
                            assetLink: "assets/newimages/large/cornerkick.png",
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ));
          return actionpadwide;
        },
      ),
    );
  }
}
