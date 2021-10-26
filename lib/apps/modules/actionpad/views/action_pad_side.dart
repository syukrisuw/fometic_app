import 'package:flutter/material.dart';
import 'dart:math' as _math;
import 'package:flutter/services.dart';
import 'package:fometic_app/apps/modules/actionpad/views/soccer_stat_button.dart';

typedef ActionpadsideCallback = void Function(String playerName, String actionPushed);

class ActionpadsideView extends StatefulWidget {
  String playerName;
  final String orientation; //(left or right)
  final double width;
  final Color backgroundColor;
  final Color padColor;
  final double opacity;
  final List<String> playerList;
  ActionpadsideCallback onButtonPushed;
  String lastAction;

  ActionpadsideView({
    Key? key,
    required this.onButtonPushed,
    required this.orientation,
    required this.playerName,
    required this.width,
    required this.playerList,

    this.backgroundColor = Colors.lightBlueAccent,
    this.padColor = Colors.blue,
    this.opacity = 1.0,
    this.lastAction = "None"
  }) : super(key: key);

  @override
  State<ActionpadsideView> createState() =>_ActionpadsideViewState();

}

class _ActionpadsideViewState extends State<ActionpadsideView> {


  void onStatButtonPushed(String actionName) {
    print("onStatButtonPushed for ${widget.playerName} doing ${actionName}");
    setState(() {
      widget.lastAction = actionName;
      widget.onButtonPushed(widget.playerName, actionName);
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedPlayer = widget.playerName;
    String playerLastAction = widget.lastAction;
    double calcSideSize = _math.min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    double sideSize = _math.max(calcSideSize/2, widget.width);

    double unpressedSize =
        ((sideSize / 5) - 1) > 10 ? ((sideSize / 5) - 1) : 10;
    double buttonSideSize = unpressedSize;
    double pressedSize = (unpressedSize - 5) > 6 ? (unpressedSize - 5) : 6;
    Widget playerList = DropdownButton<String>(
      value: selectedPlayer,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          widget.playerName = newValue!;
        });
      },
      items: widget.playerList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

    Widget actionpadside_left = Container(
        margin: EdgeInsets.all(2),
        width: sideSize,
        height: (buttonSideSize * 12) + 5,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            playerList,
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Heading",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/heading.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Shoot",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/shoot.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Long Shoot",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/shoot_long.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "New Player",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/new_player.png",
              ),
            ]),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Dribling",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/drible.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Short Pass Completed",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/pass_short.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Long Pass Completed",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/pass_long.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Player Substituted",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/substituted.png",
              ),
            ]),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Handling",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/handling.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Intercept",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/intercept.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Tackle Good",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/tackle_ok.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Foul Committed",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/foul.png",
              ),
            ]),
            SizedBox(
              height: buttonSideSize / 2,
            ),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Own Goal Committed",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/owngoal.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Tackle Foul",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/tackle_nok.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Hands Ball",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/handsball.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Off Side",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/offside.png",
              ),
            ]),
            SizedBox(
              height: buttonSideSize / 2,
            ),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Shoot Off Target",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/offtarget.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Shoot On Target",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/ontarget.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Goal",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/goal.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Ball Out Of Play",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/ballout.png",
              ),
            ]),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Goal Saved",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/goal_saving.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Assist",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/assist.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Penalty Shoot",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/penalty_shoot.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Yellow Card",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/yellowcard.png",
              ),
            ]),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Off The Ball Movement",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/offball.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Throw In",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/throwin.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Corner Kick",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/cornerkick.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Red Card",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/redcard.png",
              ),
            ]),
            Text("Player Name : "),
            Text(selectedPlayer),
            Text("Last Action :"),
            Text(playerLastAction)
          ],
        ),);

    Widget actionpadside_right = Container(
        margin: EdgeInsets.all(2),
        width: sideSize,
        height: (buttonSideSize * 12) + 5,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
         color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            playerList,
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "New Player",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/new_player.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Heading",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/heading.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Shoot",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/shoot.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Long Shoot",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/shoot_long.png",
              ),
            ]),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Player Substituted",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/substituted.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Dribling",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/drible.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Short Pass Completed",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/pass_short.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Long Shoot Completed",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/pass_long.png",
              ),
            ]),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Foul Commited",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/foul.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Handling",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/handling.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Intercept",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/intercept.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Good Tackle",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/tackle_ok.png",
              ),
            ]),
            SizedBox(
              height: buttonSideSize / 2,
            ),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Offside",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/offside.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Own Goal Committed",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/owngoal.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Tackle Foul",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/tackle_nok.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Hands Ball",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/handsball.png",
              ),
            ]),
            SizedBox(
              height: buttonSideSize / 2,
            ),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Ballout",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/ballout.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Shoot Off Target",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/offtarget.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Shoot On Target",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/ontarget.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Goal",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/goal.png",
              ),
            ]),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Yellow Card",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/yellowcard.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Goal Saved",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/goal_saving.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Assist",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/assist.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Penalty Shoot",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/penalty_shoot.png",
              ),
            ]),
            Row(children: <Widget>[
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Red Card",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/redcard.png",
              ),
              SizedBox(
                width: buttonSideSize / 2,
                height: buttonSideSize,
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Off The Ball Movement",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/offball.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Throw In",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/throwin.png",
              ),
              SoccerstatbuttonView(
                onStatButtonPushed: onStatButtonPushed,
                actionName: "Corner Kick",
                size: buttonSideSize,
                assetLink: "assets/newimages/large/cornerkick.png",
              ),
            ]),
            Text("Player Name : "),
            Text(selectedPlayer),
            Text("Last Action :"),
            Text(playerLastAction)
          ],
        ),);

    return Center(
      child: StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onTapUp: (details) {
              setState(() => {});
              HapticFeedback.mediumImpact();
              print("Actionpadside ${widget.orientation}  ${widget.lastAction} onPanEnd");
            },
            child:
              widget.orientation == "left"
                  ? actionpadside_left
                  : actionpadside_right,

          );
        },
      ),
    );
  }


}
