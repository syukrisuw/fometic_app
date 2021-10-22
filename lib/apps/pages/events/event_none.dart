import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fometic_app/apps/controllers/events_controller.dart';

class EventNoneView extends GetView<EventsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(controller.noEventTitle),
            Obx(() => Text("Counter ${controller.counter.value}")),
            TextButton(
              child: Text("Increase"),
              onPressed: () => controller.increaseCounter(),
            ),
            FloatingActionButton(

                child: Icon(Icons.add, size: 30),
                onPressed: controller.newEvent,
            ),
          ],
        )
      )
    );
  }

}