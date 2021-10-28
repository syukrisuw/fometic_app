import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_event.dart';
import 'event_none.dart';
import 'event_started.dart';
import 'package:fometic_app/apps/controllers/events_controller.dart';

class EventsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsController>(
      builder: (controller) {
        return ColoredBox(
          color: Colors.cyanAccent,
          child: IndexedStack(
            index: controller.eventViewIndex,
            children: [
              EventNoneView(),
              AddEventView(),
              EventStartedView(),
            ],
          ),
        );
      });
  }

}