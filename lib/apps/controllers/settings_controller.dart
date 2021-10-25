import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final String title = 'Settings Title';
  var counter = 0.obs;
  var activePlayerOnPadA = "".obs;
  var activePlayerOnPadB = "".obs;

  ButtonStyle inactiveStyle = TextButton.styleFrom(
      primary: Colors.black,
      backgroundColor: Colors.grey
  );

  ButtonStyle activeStyle = TextButton.styleFrom(
      primary: Colors.black,
      backgroundColor: Colors.green
  );

  ButtonStyle buttonStyleA = ButtonStyle();
  ButtonStyle buttonStyleB = ButtonStyle();
  ButtonStyle buttonStyleC = ButtonStyle();
  ButtonStyle buttonStyleD = ButtonStyle();
  ButtonStyle buttonStyleE = ButtonStyle();
  ButtonStyle buttonStyleF = ButtonStyle();
  ButtonStyle buttonStyleG = ButtonStyle();
  ButtonStyle buttonStyleH = ButtonStyle();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    inactiveAToD();
    inactiveEToH();


  }

  void inactiveAToD() {
    buttonStyleA = inactiveStyle;
    buttonStyleB = inactiveStyle;
    buttonStyleC = inactiveStyle;
    buttonStyleD = inactiveStyle;
  }

  void inactiveEToH() {
    buttonStyleE = inactiveStyle;
    buttonStyleF = inactiveStyle;
    buttonStyleG = inactiveStyle;
    buttonStyleH = inactiveStyle;
  }

  void increaseCounter() {
    counter.value += 1;
  }

  void changePlayer(String padName, String playerName, int buttonNumber) {
    print("[SettingsController:changePlayer] padName: ${padName} , playerName: ${playerName}");
    if (padName=="Pad A"){
      activePlayerOnPadA.value = playerName;
    } else {
      activePlayerOnPadB.value = playerName;
    }

    if (buttonNumber <5 ) {
      inactiveAToD();
      if (buttonNumber==1) buttonStyleA = activeStyle;
      if (buttonNumber==2) buttonStyleB = activeStyle;
      if (buttonNumber==3) buttonStyleC = activeStyle;
      if (buttonNumber==4) buttonStyleD = activeStyle;

    } else {
      inactiveEToH();
      if (buttonNumber==5) buttonStyleE = activeStyle;
      if (buttonNumber==6) buttonStyleF = activeStyle;
      if (buttonNumber==7) buttonStyleG = activeStyle;
      if (buttonNumber==8) buttonStyleH = activeStyle;
    }

    update();

  }


}// TODO Implement this library.