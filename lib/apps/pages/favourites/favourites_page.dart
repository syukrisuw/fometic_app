import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fometic_app/apps/controllers/favourites_controller.dart';

class FavouritesPage extends GetView<FavouritesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(controller.title),
              Obx(() => Text("Counter ${controller.counter.value}")),
              TextButton(
                child: Text("Increase"),
                onPressed: () => controller.increaseCounter(),
              )
            ],
          ),
        ),
      ),
    );
  }
}