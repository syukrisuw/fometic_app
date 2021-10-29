import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fometic_app/apps/modules/dialogs/add_player_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import 'package:fometic_app/apps/controllers/events_controller.dart';

class AddEventView extends GetView<EventsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: Column(
              children: <Widget>[
                Obx(() => SizedBox(
                    key: UniqueKey(),//Map section
                    width: controller.mapWidth.toDouble(),
                    height: 100,
                    child: FlutterMap(
                      options: MapOptions(
                        center: controller.getCurrentLatLang(),
                        zoom: 15.0,
                      ),
                      layers: [
                        MarkerLayerOptions(
                          markers: [
                            Marker(
                              width: 60.0,
                              height: 60.0,
                              point: controller.getCurrentLatLang(),
                              builder: (ctx) => Container(
                                child: FlutterLogo(),
                              ),
                            ),
                          ],
                        ),
                      ],
                      children: <Widget>[
                        TileLayerWidget(
                            options: TileLayerOptions(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c'])),
                        MarkerLayerWidget(
                            options: MarkerLayerOptions(
                          markers: [
                            Marker(
                              width: 60.0,
                              height: 60.0,
                              point: controller.getCurrentLatLang(),
                              builder: (ctx) => Container(
                                child: FlutterLogo(),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ))),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 10,
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Obx(() => Text("Lat: ${controller.locationLat}")),
                        Obx(() =>
                            Text("Long: ${controller.locationLong}")),
                        TextButton(
                            onPressed: controller.onLocationButtonPressed,
                            child: Text("Get Location"))
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Obx(() => Text("Event Name ${controller.event_name.value}")),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.eventNameTextController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name of the event",
                      labelText: "Event Name",
                      labelStyle: TextStyle(fontSize: 24, color: Colors.black)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.eventTotalPlayerTextController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Total Player",
                      labelText: "Total Number of Player",
                      labelStyle: TextStyle(fontSize: 24, color: Colors.black)),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Player List'),
                    TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          int registeredPlayer = int.parse(controller.eventTotalPlayerTextController.text);
                          int addedPlayer = controller.playerModelList.length;
                          if (registeredPlayer == addedPlayer){
                            Get.defaultDialog(
                              title: "Alert",
                              content: Text("Already Max Player Added")
                            );
                          } else {
                            Get.dialog(AddPlayerDialog(
                                onConfirmCallback: controller
                                    .onAddPlayerConfirm,
                                onCancelCallback: controller
                                    .onAddPlayerCancel));
                          }
                        },
                        child: Text("Add Player")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Number"),
                    Text("Player Name"),
                    Text("Position"),
                    Text("Remove Player"),
                  ],
                ),
                Container(
                  color: Colors.black12,
                  width: MediaQuery.of(context).size.width - 10,
                  height: 100,
                  child: Obx(
                    () => ListView.builder(
                      //physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.playerModelList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(controller.playerModelList[index].playerNumber
                                .toString()),
                            Text(controller.playerModelList[index].playerName),
                            Text(controller
                                .playerModelList[index].playerPosition),
                            Text(
                                controller.playerModelList[index].playerStatus),
                            TextButton(
                                onPressed: () {
                                  controller.onRemovePlayer(index);
                                },
                                child: Text("Remove Player"))
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          controller.cancelEvent();
                        },
                        child: Text("Cancel Event")),
                    TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          bool isEventDataValid = false;
                          String validationMessage = "";
                          if ((controller.eventNameTextController.text != "") ||
                              (controller
                                  .eventNameTextController.text.isNotEmpty)) {
                            isEventDataValid = true;
                            validationMessage = "Event Data Valid";
                          } else {
                            isEventDataValid = false;
                            validationMessage = "Invalid Event Name";
                          }

                          if (controller.eventTotalPlayerTextController.text ==
                              controller.totalPlayer.toString()) {
                            if (controller.totalPlayer > 1) {
                              isEventDataValid = true;
                              validationMessage = "Event Data Valid";
                            } else {
                              isEventDataValid = false;
                              validationMessage = "Total Player Less than 2";
                            }
                          } else {
                            isEventDataValid = false;
                            validationMessage = "Total Event Player(${controller.eventTotalPlayerTextController.text}) Diffrent than Added Player(${controller.totalPlayer})";
                          }

                          print(
                              "controller.eventNameTextController.text:<${controller.eventNameTextController.text}>");
                          print(
                              "controller.eventTotalPlayerTextController.text:<${controller.eventTotalPlayerTextController.text}>");
                          print(
                              "controller.eventNameTextController.text:<${controller.totalPlayer}>");

                          if (isEventDataValid) {
                            controller.playerAList.clear();
                            controller.playerBList.clear();
                            int divider = (controller.totalPlayer.value/2).ceil();
                            for (var i = 0; i<divider;i++){
                              controller.playerAList.add(controller.playerModelList[i].playerName);
                            }
                            for (var j = 0; j<divider;j++){
                              if ( j+divider < controller.totalPlayer.value) {
                                controller.playerBList.add(
                                    controller.playerModelList[j + divider]
                                        .playerName);
                              }
                            }


                            controller.startNewEvent(
                                controller.eventNameTextController.text,
                                controller.eventTotalPlayerTextController.text);
                          } else {
                            Get.defaultDialog(
                              title: "Alert",
                              content: Text("Event Data Belum Lengkap : ${validationMessage}"),
                            );
                          }
                        },
                        child: Text("Start Event")),
                  ],
                )
              ],
            ),
          ),
          physics: NeverScrollableScrollPhysics(),
        ));
  }
}
