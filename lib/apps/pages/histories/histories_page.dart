import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fometic_app/apps/modules/actionpad/views/action_pad_large.dart';
import 'package:fometic_app/apps/modules/actionpad/views/action_pad_side.dart';
import 'package:get/get.dart';

import 'package:fometic_app/apps/controllers/histories_controller.dart';

class HistoriesPage extends GetView<HistoriesController> {
  String _activePlayer = "";
  String _playerA = "";
  String _playerB = "";
  String _lastActionA ="";
  String _lastActionB = "";

  @override
  Widget build(BuildContext context) {
    List<String> playerAList = ['Abud', 'Agus', 'Alex', 'Andre'];
    List<String> playerBList = ['Bagus', 'Bani', 'Bernhard', 'Boby'];

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: [
            Text(controller.title),
            Obx(() => Text("Player ${controller.playerAName.value} Doing ${controller.lastActionA.value}")),
            Obx(() => Text("Player ${controller.playerBName.value} Doing ${controller.lastActionB.value}")),
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
                          child: ActionpadsideView(playerList: playerAList, onButtonPushed: controller.onButtonAPushed, playerName: playerAList[0], orientation: "left", width: MediaQuery.of(context).size.width/2)
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
                          child: ActionpadsideView(playerList: playerBList, onButtonPushed: controller.onButtonBPushed, playerName: playerBList[0], orientation: "right", width: MediaQuery.of(context).size.width/2)
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
