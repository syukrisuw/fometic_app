import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as _math;
import 'package:flutter/services.dart';
import 'package:fometic_app/apps/modules/actionpad/views/player_select_button.dart';
import 'package:fometic_app/apps/modules/actionpad/views/soccer_stat_button.dart';

typedef ActionpadCompactCallback = void Function(
    String playerName, String actionPushed);

class ActionpadCompactView extends StatefulWidget {
  //2 3x3 button with radio button selected player
  //maximum 6 player selection per pad
  final String orientation; //(left or right)
  final double width;
  final double height;
  int playerSelectionTotal;
  int playerSelectionTotalRowTotal;
  final Color backgroundColor;
  final Color padColor;
  final double opacity;
  List<String> playerList;
  ActionpadCompactCallback onButtonPushed;
  String lastAction;
  final MaterialColor selectedColor;
  final MaterialColor unselectedColor;

  ActionpadCompactView(
      {Key? key,
      required this.onButtonPushed,
      required this.orientation,
      required this.width,
      required this.playerList,
      this.playerSelectionTotal = 1,
      this.playerSelectionTotalRowTotal = 1,
      this.height = 100,
      this.backgroundColor = Colors.lightBlueAccent,
      this.padColor = Colors.blue,
      this.opacity = 1.0,
      this.lastAction = "None",
      this.selectedColor = Colors.lightGreen,
      this.unselectedColor = Colors.blueGrey})
      : super(key: key);

  @override
  State<ActionpadCompactView> createState() => _ActionpadCompactView();
}

class _ActionpadCompactView extends State<ActionpadCompactView> {
  List<MaterialColor> buttonColorList = [];
  String selectedPlayerName = "";
  List<String> playerSelectionList = [];

  @override
  void initState() {
    // TODO: implement initState
    playerSelectionList = getValidPlayerList();
    selectedPlayerName = playerSelectionList[0];
    for (var i = 0; i < playerSelectionList.length; i++) {
      if (playerSelectionList[i] == selectedPlayerName) {
        buttonColorList.add(this.widget.selectedColor);
      } else {
        buttonColorList.add(this.widget.unselectedColor);
      }
    }
    super.initState();
  }
  void resetButtonColor() {
    for (var i = 0; i < buttonColorList.length; i++) {
      buttonColorList[i] = this.widget.unselectedColor;
    }
  }

  void onPlayerSelectButtonPushed(String playerName) {
    print("onPlayerSelectButtonPushed for ${playerName} ");
    setState(() {
      selectedPlayerName = playerName;
      widget.onButtonPushed(selectedPlayerName, "selected");
      int buttonIndex = getValidPlayerList().indexOf(playerName);
      resetButtonColor();
      buttonColorList[buttonIndex] = this.widget.selectedColor;
    });
  }

  void onStatButtonPushed(String playerAction) {
    print("onStatButtonPushed for ${selectedPlayerName} doing ${playerAction}");
    setState(() {
      widget.lastAction = playerAction;
      widget.onButtonPushed(selectedPlayerName, playerAction);
    });
  }

  int getValidPlayerSelectionRow() {
    widget.playerSelectionTotalRowTotal =
        (widget.playerList.length / 2).floor().toInt();
    return widget.playerSelectionTotalRowTotal;
  }

  List<String> getValidPlayerList() {
    int inputPlayerTotal = widget.playerList.length;
    switch (inputPlayerTotal) {
      case 1:
        {
          widget.playerList.add("NONE");
          widget.playerSelectionTotal = 2;
        }
        break;
      case 2:
        {
          widget.playerSelectionTotal = 2;
        }
        break;
      case 3:
        {
          widget.playerList.add("NONE");
          widget.playerSelectionTotal = 4;
        }
        break;
      case 4:
        {
          widget.playerSelectionTotal = 4;
        }
        break;
      case 5:
        {
          widget.playerList.add("NONE");
          widget.playerSelectionTotal = 6;
        }
        break;
      case 6:
        {
          widget.playerSelectionTotal = 6;
        }
        break;
      case 7:
        {
          widget.playerList.add("NONE");
          widget.playerSelectionTotal = 8;
        }
        break;
      case 8:
        {
          widget.playerSelectionTotal = 8;
        }
        break;
      default:
        {
          if (inputPlayerTotal > 8) {
            widget.playerSelectionTotal = 8;
          } else if ((inputPlayerTotal < 1)) {
            widget.playerSelectionTotal = 2;
          }
        }
    }
    return widget.playerList;
  }

  double getValidPlayerSelectionButtonWidth() {
    return ((widget.width / 2) - 1).floorToDouble();
  }

  double getValidPlayerSelectionButtonHeight() {
    return ((widget.height / 10) - 1).floorToDouble();
  }

  @override
  Widget build(BuildContext context) {
    double playerSelectionButtonWidth = getValidPlayerSelectionButtonWidth();
    double playerSelectionButtonHeight = getValidPlayerSelectionButtonHeight();


    if ((selectedPlayerName == "") || (selectedPlayerName == "NONE")) {
      if (playerSelectionList.isNotEmpty) {
        selectedPlayerName = playerSelectionList[0];
        buttonColorList[0] = this.widget.selectedColor;
      }
    }

    int totalSelectionRow = getValidPlayerSelectionRow();

    String playerLastAction = widget.lastAction;
    double calcSideSize = _math.min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    double sideSize = _math.max(calcSideSize / 2, widget.width);

    double unpressedSize =
        ((sideSize / 4) - 1) > 10 ? ((sideSize / 4) - 1) : 10;
    double buttonSideSize = unpressedSize;

    Widget playerSelection = Column(children: <Widget>[
      for (int i = 0; i < totalSelectionRow; i++)
        Row(children: [
          SizedBox(
            child: PlayerSelectButtonView(
              onPlayerSelectButtonPushed: onPlayerSelectButtonPushed,
              width: sideSize / 2 - 4,
              height: buttonSideSize / 2 - 1,
              playerName: playerSelectionList[(i * 2)],
              buttonColor: buttonColorList[(i * 2)],
              assetLink: "assets/images/arrow_t_80.png",
            ),
          ),
          SizedBox(
            child: PlayerSelectButtonView(
              onPlayerSelectButtonPushed: onPlayerSelectButtonPushed,
              width: sideSize / 2 - 4,
              height: buttonSideSize / 2 - 1,
              buttonColor: buttonColorList[(i * 2) + 1],
              playerName: playerSelectionList[(i * 2) + 1],
              isActive:
                  (playerSelectionList[(i * 2) + 1] == "NONE") ? false : true,
              assetLink: "assets/images/arrow_t_80.png",
            ),
          ),
        ])
    ]);

    Widget actionpadside_left = Container(
      margin: EdgeInsets.all(2),
      width: sideSize,
      height: (buttonSideSize * 14) + 5,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          playerSelection,
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Handling",
                    doubleTapAction: "Lost Ball",
                    longTapAction: "Injured",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/handling.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Shoot",
                    doubleTapAction: "Long Shoot",
                    longTapAction: "Penalty Shoot",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/shoot.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Off Target",
                    doubleTapAction: "On Target",
                    longTapAction: "Ball Out",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/offtarget.png",
                  ),
                ]),
                Row(children: <Widget>[
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Dribling",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/drible.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Short Pass Completed",
                    doubleTapAction: "Cross Pass Completed",
                    longTapAction: "Long Pass Completed",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/pass_short.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Goal",
                    doubleTapAction: "First time hit Goal",
                    longTapAction: "Penalty Goal",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/goal.png",
                  ),
                ]),
                Row(children: <Widget>[
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Intercept Completed",
                    doubleTapAction: "Intercept Failed",
                    longTapAction: "Foul",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/intercept.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Throw In Completed",
                    doubleTapAction: "Throw In Failed",
                    longTapAction: "Corner Kick",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/throwin.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Assist",
                    doubleTapAction: "Assist Using Heading",
                    longTapAction: "Fantastic Assist",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/assist.png",
                  ),
                ]),
                SizedBox(
                  height: buttonSideSize / 2,
                ),
                Row(children: <Widget>[
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Off Ball Movement",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/offball.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Handsball",
                    doubleTapAction: "Intentional Handsball",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/handsball.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Goal Saving",
                    doubleTapAction: "Goal Tipped",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/goal_saving.png",
                  ),
                ]),
                Row(children: <Widget>[
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Player Out Substituted",
                    doubleTapAction: "Player In For Substitution",
                    longTapAction: "Player Injured Bad",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/substituted.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Yellow Card Commited",
                    doubleTapAction: "Second Yellow Card Commited",
                    longTapAction: "Direct Red Card Commited",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/yellowcard.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Tackle Foul Committed",
                    doubleTapAction: "Dangerous Tackle Foul Committed",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/tackle_nok.png",
                  ),
                ]),
                Row(children: <Widget>[
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Foul Committed",
                    doubleTapAction: "Off Side Foul",
                    longTapAction: "Dangerous Foul Committed",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/foul.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Ball Out of Play",
                    doubleTapAction: "Ball Out for Corner",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/ballout.png",
                  ),
                  SoccerstatbuttonView(
                    onStatButtonPushed: onStatButtonPushed,
                    singleTapAction: "Own Goal",
                    doubleTapAction: "Goal Keeper Foul",
                    size: buttonSideSize,
                    assetLink: "assets/newimages/large/owngoal.png",
                  ),
                ]),
              ],
            ),
          ),
          Text("Player Name : "),
          Text(selectedPlayerName),
          Text("Last Action :"),
          Text(playerLastAction)
        ],
      ),
    );

    Widget actionpadside_right = Container(
      margin: EdgeInsets.all(2),
      width: sideSize,
      height: (buttonSideSize * 14) + 5,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          playerSelection,
          Container(
            padding: EdgeInsets.only(right: 20),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Handling",
                        doubleTapAction: "Lost Ball",
                        longTapAction: "Injured",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/handling.png",
                      ),
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Shoot",
                        doubleTapAction: "Long Shoot",
                        longTapAction: "Penalty Shoot",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/shoot.png",
                      ),
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Off Target",
                        doubleTapAction: "On Target",
                        longTapAction: "Ball Out",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/offtarget.png",
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Dribling",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/drible.png",
                      ),
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Short Pass Completed",
                        doubleTapAction: "Cross Pass Completed",
                        longTapAction: "Long Pass Completed",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/pass_short.png",
                      ),
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Goal",
                        doubleTapAction: "First time hit Goal",
                        longTapAction: "Penalty Goal",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/goal.png",
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Intercept Completed",
                        doubleTapAction: "Intercept Failed",
                        longTapAction: "Foul",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/intercept.png",
                      ),
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Throw In Completed",
                        doubleTapAction: "Throw In Failed",
                        longTapAction: "Corner Kick",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/throwin.png",
                      ),
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Assist",
                        doubleTapAction: "Assist Using Heading",
                        longTapAction: "Fantastic Assist",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/assist.png",
                      ),
                    ]),
                SizedBox(
                  height: buttonSideSize / 2,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Off Ball Movement",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/offball.png",
                      ),
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Handsball",
                        doubleTapAction: "Intentional Handsball",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/handsball.png",
                      ),
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Goal Saving",
                        doubleTapAction: "Goal Tipped",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/goal_saving.png",
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Player Out Substituted",
                        doubleTapAction: "Player In For Substitution",
                        longTapAction: "Player Injured Bad",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/substituted.png",
                      ),
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Yellow Card Commited",
                        doubleTapAction: "Second Yellow Card Commited",
                        longTapAction: "Direct Red Card Commited",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/yellowcard.png",
                      ),
                      SoccerstatbuttonView(
                        onStatButtonPushed: onStatButtonPushed,
                        singleTapAction: "Tackle Foul Committed",
                        doubleTapAction: "Dangerous Tackle Foul Committed",
                        size: buttonSideSize,
                        assetLink: "assets/newimages/large/tackle_nok.png",
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SoccerstatbuttonView(
                      onStatButtonPushed: onStatButtonPushed,
                      singleTapAction: "Foul Committed",
                      doubleTapAction: "Off Side Foul",
                      longTapAction: "Dangerous Foul Committed",
                      size: buttonSideSize,
                      assetLink: "assets/newimages/large/foul.png",
                    ),
                    SoccerstatbuttonView(
                      onStatButtonPushed: onStatButtonPushed,
                      singleTapAction: "Ball Out of Play",
                      doubleTapAction: "Ball Out for Corner",
                      size: buttonSideSize,
                      assetLink: "assets/newimages/large/ballout.png",
                    ),
                    SoccerstatbuttonView(
                      onStatButtonPushed: onStatButtonPushed,
                      singleTapAction: "Own Goal",
                      doubleTapAction: "Goal Keeper Foul",
                      size: buttonSideSize,
                      assetLink: "assets/newimages/large/owngoal.png",
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text("Player Name : "),
          Text(selectedPlayerName),
          Text("Last Action :"),
          Text(playerLastAction)
        ],
      ),
    );

    return Center(
      child: StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onTapUp: (details) {
              setState(() => {});
              HapticFeedback.mediumImpact();
              print(
                  "Actionpadside ${widget.orientation}  ${widget.lastAction} onPanEnd");
            },
            child: widget.orientation == "left"
                ? actionpadside_left
                : actionpadside_right,
          );
        },
      ),
    );
  }
}
