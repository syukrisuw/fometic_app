import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fometic_app/apps/modules/actionpad/views/action_pad.dart';
import 'package:fometic_app/apps/modules/actionpad/views/action_pad_large.dart';
import 'package:fometic_app/apps/controllers/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {

  ButtonStyle inactiveStyle = TextButton.styleFrom(
  primary: Colors.black,
  backgroundColor: Colors.grey
  );

  ButtonStyle activeStyle = TextButton.styleFrom(
      primary: Colors.black,
      backgroundColor: Colors.green
  );

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
              Container(
                decoration: BoxDecoration (
                  border: Border.all(color: Colors.grey),
                ),
                child: Row (
                  children:<Widget> [
                    ActionpadLargeView(
                      size: MediaQuery.of(context).size.width-10,
                    ),
                    Column(
                      children: [
                        Obx(() => Text("Action Pad For : ${controller.activePlayerOnPadA.value}")),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () => {
                            controller.changePlayer("Pad A", "Player A", 1)
                          },
                          child: Text("Player A"),
                          style: controller.buttonStyleA
                        ),
                        TextButton(
                          onPressed: () => {
                            controller.changePlayer("Pad A", "Player B", 2)
                          },
                          child: Text("Player B"),
                          style: controller.buttonStyleB
                        ),TextButton(
                          onPressed: () => {
                            controller.changePlayer("Pad A", "Player C", 3)
                          },
                          child: Text("Player C"),
                          style: controller.buttonStyleC
                        ),
                        TextButton(
                          onPressed: () => {
                            controller.changePlayer("Pad A", "Player D", 4)
                          },
                          child: Text("Player D"),
                          style: controller.buttonStyleD
                        ),
                      ],
                    )
                  ]
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration (
                  border: Border.all(color: Colors.grey),
                ),
                child: Row (
                    children:<Widget> [
                      ActionpadView(
                        size: MediaQuery.of(context).size.width-10,
                      ),
                      Column(
                        children: [
                          Obx(() => Text("Action Pad For : ${controller.activePlayerOnPadB.value}")),
                          TextButton(
                            onPressed: () => {
                              controller.changePlayer("Pad B", "Player E", 5)
                            },
                            child: Text("Player E"),
                            style: controller.buttonStyleE
                          ),
                          TextButton(
                            onPressed: () => {
                              controller.changePlayer("Pad B", "Player F", 6)
                            },
                            child: Text("Player F"),
                            style: controller.buttonStyleF
                          ),TextButton(
                            onPressed: () => {
                              controller.changePlayer("Pad B", "Player G", 7)
                            },
                            child: Text("Player G"),
                            style: controller.buttonStyleG
                          ),TextButton(
                            onPressed: () => {
                              controller.changePlayer("Pad B", "Player H", 8)
                            },
                            child: Text("Player H"),
                            style: controller.buttonStyleH
                          ),
                        ],
                      )
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setActivePlayer(String playerName) {

  }


}