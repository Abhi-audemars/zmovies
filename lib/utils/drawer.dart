import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:zmovies/pages/homepage.dart';
import 'package:zmovies/utils/menuscreen.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      borderRadius: 24.0,
      showShadow: true,
      drawerShadowsBackgroundColor: Color.fromARGB(255, 147, 124, 147),
      duration: Duration(seconds: 1),
      mainScreen: HomePage(),
      menuScreen: menuScreen(),
    );
  }
}
