import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fometic_app/apps/modules/actionpad/views/action_pad_compact.dart';
import 'package:get/get.dart';

import 'package:fometic_app/apps/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  String _activePlayer = "";
  String _playerA = "";
  String _playerB = "";
  String _lastActionA ="";
  String _lastActionB = "";

  @override
  Widget build(BuildContext context) {
    List<String> playerAList = ['Abud', 'Agus', 'Alex', 'Andre', 'Azul'];
    List<String> playerBList = ['Bagus', 'Bani', 'Bern', 'Boby','Babeh', 'Bebi', 'Barton', 'Boni', 'Bert'];

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: [
            Text(controller.title),
            Text("Event Name |  Execution Time | Player Name | Action Name"),
            Obx(() => Text("Event_Name,${controller.statTimeA.value},${controller.playerAName.value},${controller.lastActionA.value}")),
            Obx(() => Text("Event_Name,${controller.statTimeB.value},${controller.playerBName.value},${controller.lastActionB.value}")),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 550,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top:0,
                      left:0,
                      child: Container (
                          width:MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                          ),
                          height: 500,
                          child: ActionpadCompactView(playerList: playerAList, onButtonPushed: controller.onButtonAPushed, orientation: "left", width: MediaQuery.of(context).size.width/2)
                      ),
                    ),
                    Positioned(
                      top:0,
                      right:0,
                      child: Container (
                          width:MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                          ),
                          height: 500,
                          child: ActionpadCompactView(playerList: playerBList, onButtonPushed: controller.onButtonBPushed, orientation: "right", width: MediaQuery.of(context).size.width/2)
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
