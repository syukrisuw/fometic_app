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
              Text("Using Sample https://httpbin.org/base64/xxxx"),
              ElevatedButton(
                child: Text("Get Data From Backend"),
                onPressed: () => controller.getData(),
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration (
                  border: Border.all(color: Colors.blueAccent),
                ),
                child:
                SingleChildScrollView(
                  child :
                  Obx(() => Text("Data :  ${controller.dataString.value}")),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}