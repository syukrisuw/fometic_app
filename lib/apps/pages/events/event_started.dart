import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:control_pad/control_pad.dart';

import 'package:fometic_app/apps/controllers/events_controller.dart';

class EventStartedView extends GetView<EventsController> {
  TextEditingController _eventnameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack (
        children: [
        Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Obx(() => Text("Event Name ${controller.event_name.value}")),
            SizedBox(
              height: 20,
            ),
            Obx(() => Text("Total Player ${controller.total_player.value}")),
            SizedBox(
              height: 20,
            ),
            Text("Event Start Time ${controller.eventStartTime.toIso8601String()}"),
            SizedBox(
              height: 100,
              child: Container (
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration (
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/2 - 30,
                      decoration: BoxDecoration (
                        border: Border.all(color: Colors.red),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2 - 30,
                      decoration: BoxDecoration (
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
                  width: MediaQuery.of(context).size.width/2,
                  height: 180,
                  child: Column (
                    children: <Widget> [
                      JoystickView(
                        iconsColor: Colors.deepOrange,
                        backgroundColor: Colors.amber,
                        innerCircleColor: Colors.blue,
                        opacity: 0.8,
                        size: 100.0,
                        interval: const Duration(milliseconds : 500),
                        onDirectionChanged: controller.padACallback,
                      ),
                      TextButton(
                          onPressed: controller.setupPlayer,
                          child: Text("Setup Player"),
                      ),
                    ]
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  height: 180,
                  child: Column (
                      children: <Widget> [
                        JoystickView(
                          iconsColor: Colors.deepOrange,
                          backgroundColor: Colors.amber,
                          innerCircleColor: Colors.blue,
                          opacity: 0.8,
                          size: 100.0,
                          interval: const Duration(milliseconds : 500),
                          onDirectionChanged: controller.padBCallback,
                        ),
                        TextButton(
                          onPressed: controller.setupPlayer,
                          child: Text("Setup Player"),
                        ),
                      ]
                  ),
                ),

              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  height: 180,
                  child: Column (
                      children: <Widget> [
                        JoystickView(
                          iconsColor: Colors.deepOrange,
                          backgroundColor: Colors.amber,
                          innerCircleColor: Colors.blue,
                          opacity: 0.8,
                          size: 100.0,
                          interval: const Duration(milliseconds : 500),
                          onDirectionChanged: controller.padCCallback,
                        ),
                        TextButton(
                          onPressed: controller.setupPlayer,
                          child: Text("Setup Player"),
                        ),
                      ]
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  height: 180,
                  child: Column (
                      children: <Widget> [
                        JoystickView(
                          iconsColor: Colors.deepOrange,
                          backgroundColor: Colors.amber,
                          innerCircleColor: Colors.blue,
                          opacity: 0.8,
                          size: 100.0,
                          interval: const Duration(milliseconds : 500),
                          onDirectionChanged: controller.padDCallback,
                        ),
                        TextButton(
                          onPressed: controller.setupPlayer,
                          child: Text("Setup Player"),
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ],
        ),
          Positioned(
              bottom: 10,
              right: 10,
              child: TextButton(
                  onPressed: controller.stopEvent,
                  child: Text("Stop Event")
              )
          ),
      ]
    )
    );
  }

}