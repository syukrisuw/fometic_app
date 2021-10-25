import 'package:flutter/material.dart';
import 'package:fometic_app/apps/modules/actionpad/views/action_pad_large.dart';
import 'package:fometic_app/apps/modules/actionpad/views/action_pad_wide.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(controller.title),
            ActionpadwideView(size: MediaQuery.of(context).size.width)
          ],
        ),
      ),
    );
  }
}// TODO Implement this library.