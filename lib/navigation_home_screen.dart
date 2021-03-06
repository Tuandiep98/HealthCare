import 'package:best_flutter_ui_templates/Screen/lesson_screen.dart';
import 'package:best_flutter_ui_templates/Screen/meditation_screen.dart';
import 'package:best_flutter_ui_templates/Screen/running_screen.dart';
import 'package:best_flutter_ui_templates/theme/app_theme.dart';
import 'package:best_flutter_ui_templates/custom_drawer/drawer_user_controller.dart';
import 'package:best_flutter_ui_templates/custom_drawer/home_drawer.dart';
import 'package:best_flutter_ui_templates/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/traning/training_screen.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';

import 'Screen/account_screen.dart';
import 'fitness_app/models/user.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;
  User main = User.main;
  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    //screenView = const MyHomePage();
    screenView = FitnessAppHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = FitnessAppHomeScreen();
        });
      } else if (drawerIndex == DrawerIndex.Run) {
        setState(() {
          screenView = RunScreen();
        });
      } else if (drawerIndex == DrawerIndex.Meditation) {
        setState(() {
          screenView = MeditationScreen();
        });
      } else if (drawerIndex == DrawerIndex.Lesson) {
        setState(() {
          screenView = LessonScreen();
        });
      } else if (drawerIndex == DrawerIndex.Setting) {
        setState(() {
          screenView = FitnessAppHomeScreen();
        });
      } else if (drawerIndex == DrawerIndex.Account) {
        setState(() {
          screenView = AccountScreen();
        });
      }
    }
  }
}
