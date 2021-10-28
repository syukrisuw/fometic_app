import 'package:flutter/material.dart';
import 'package:fometic_app/apps/modules/actionpad/views/action_pad_compact.dart';
import 'package:get/get.dart';

import 'package:fometic_app/apps/controllers/events_controller.dart';

class EventStartedView extends GetView<EventsController> {
  TextEditingController _eventnameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
          key: UniqueKey(),
      physics: NeverScrollableScrollPhysics(),
      child: (Stack(children: [
        Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Obx(() => Text("Event Name ${controller.event_name.value}  Total Player ${controller.total_player.value}")),
            SizedBox(
              height: 10,
            ),
            Text(
                "Event Start Time ${controller.eventStartTime.toIso8601String()}"),
            SizedBox(
              height: 80,
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height - 300,
                  child: ActionpadCompactView(key: UniqueKey(), playerList: controller.playerAList, onButtonPushed: controller.onButtonAPushed, orientation: "left", width: MediaQuery.of(context).size.width/2)

                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height - 300,
                    child: ActionpadCompactView(key: UniqueKey(), playerList: controller.playerBList, onButtonPushed: controller.onButtonBPushed, orientation: "right", width: MediaQuery.of(context).size.width/2)

    ),
              ],
            ),
          ],
        ),
        Positioned(
            bottom: 10,
            right: 10,
            child: TextButton(
                onPressed: controller.stopEvent, child: Text("Stop Event"))),
      ])),
    ));
  }
}
