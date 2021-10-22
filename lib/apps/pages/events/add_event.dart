import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fometic_app/apps/controllers/events_controller.dart';

class AddEventView extends GetView<EventsController> {
  TextEditingController _eventNameTextController = TextEditingController();
  TextEditingController _eventTotalPlayerTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Obx(() => Text("Event Name ${controller.event_name.value}")),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _eventNameTextController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText:"Name of the event",
              labelText: "Event Name",
              labelStyle: TextStyle (
                fontSize: 24,
                color: Colors.black
              )
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _eventTotalPlayerTextController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText:"Total Player",
                labelText: "Total Number of Player",
                labelStyle: TextStyle (
                    fontSize: 24,
                    color: Colors.black
                )
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 50,
          ),
          Row (
            children: [
              TextButton(
                  onPressed: () {
                    controller.cancelEvent();
                  },
                  child: Text("Cancel Event")
              ),
              TextButton(
                  onPressed: () {
                    controller.startNewEvent(_eventNameTextController.text, _eventTotalPlayerTextController.text);
                  },
                  child: Text("Start Event")
              ),
            ],
          )


        ],
      ),
    );
  }

}