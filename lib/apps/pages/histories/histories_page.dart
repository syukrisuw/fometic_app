import 'package:flutter/material.dart';
import 'package:fometic_app/apps/modules/actionpad/views/action_pad_large.dart';
import 'package:get/get.dart';

import 'package:fometic_app/apps/controllers/histories_controller.dart';

class HistoriesPage extends GetView<HistoriesController> {
  String _activePlayer = "";

  void _changePlayer(String padName, String playerName) {
    _activePlayer = playerName;
  }



  @override
  Widget build(BuildContext context) {
    var _maxSide = MediaQuery.of(context).size.width/7.toInt();
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
              ),
              Row (
                children: <Widget>[
                  ActionpadLargeView(
                    size: 300,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/7.toInt(),
                    child: Column (
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                          child: Text("Player A",textScaleFactor: 0.6)
                        ),
                        SizedBox(
                            height: 15,
                            child: Text("Player B",textScaleFactor: 0.6)
                        ),
                        SizedBox(
                            height: 15,
                            child: Text("Player C",textScaleFactor: 0.6)
                        ),
                        SizedBox(
                            height: 15
                        ),
                        SizedBox(
                            height: 15
                        ),
                        SizedBox(
                            height: 15,
                            child: Text("Player D",textScaleFactor: 0.6)
                        ),
                        SizedBox(
                            height: 15,
                            child: Text("Player E",textScaleFactor: 0.6)
                        ),
                        SizedBox(
                            height: 15,
                            child: Text("Player F",textScaleFactor: 0.6)
                        ),
                      ],
                    )
                  ),
                  ActionpadLargeView(
                    size: 200,
                  ),
                ]
              ),
              Row (
                  children: <Widget>[
                    ActionpadLargeView(
                      size: 200,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width/7.toInt(),
                        child: Column (
                          children: <Widget>[
                            SizedBox(
                                height: 15,
                                child: Text("Player G",textScaleFactor: 0.6)
                            ),
                            SizedBox(
                                height: 15,
                                child: Text("Player H",textScaleFactor: 0.6)
                            ),
                            SizedBox(
                                height: 15,
                                child: Text("Player I",textScaleFactor: 0.6)
                            ),
                            SizedBox(
                                height: 15
                            ),
                            SizedBox(
                                height: 15
                            ),
                            SizedBox(
                                height: 15,
                                child: Text("Player J",textScaleFactor: 0.6)
                            ),
                            SizedBox(
                                height: 15,
                                child: Text("Player K",textScaleFactor: 0.6)
                            ),
                            SizedBox(
                                height: 15,
                                child: Text("Player L",textScaleFactor: 0.6)
                            ),
                          ],
                        )
                    ),
                    ActionpadLargeView(
                      size: 200,
                    ),
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}// TODO Implement this library.