import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fometic_app/apps/pages/home/home_page.dart';
import 'package:fometic_app/apps/pages/settings/settings_page.dart';
import 'package:fometic_app/apps/pages/histories/histories_page.dart';
import 'package:fometic_app/apps/pages/events/events_page.dart';
import 'package:fometic_app/apps/pages/favourites/favourites_page.dart';
//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:fometic_app/apps/controllers/main_controller.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Fometic Mobile Application'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
                },
              ),
            ],
          ),
          body: SafeArea(
            child: ColoredBox (
              color: Colors.cyanAccent,
              child: IndexedStack(
                index: controller.tabIndex,
                children: [
                  HomePage(),
                  FavouritesPage(),
                  EventsPage(),
                  HistoriesPage(),
                  SettingsPage(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavyBar(
              selectedIndex: controller.tabIndex,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              onItemSelected: controller.changeTabIndex,
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon:  Icon(Icons.home, size: 30),
                  title: Text('Home'),
                  activeColor: Colors.red,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon: Icon(Icons.favorite, size: 30),
                  title: Text('Favourites'),
                  activeColor: Colors.red,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon:  Icon(Icons.workspaces_outline, size: 30),
                  title: Text('Events'),
                  activeColor: Colors.red,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon:  Icon(Icons.assignment_outlined, size: 30),
                  title: Text('Histories'),
                  activeColor: Colors.red,
                  textAlign: TextAlign.center,
                ),
                BottomNavyBarItem(
                  icon:  Icon(Icons.settings, size: 30),
                  title: Text('Settings'),
                  activeColor: Colors.red,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        );
      },
    );
  }

}