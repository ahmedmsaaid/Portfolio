import 'package:flutter/material.dart';

/// In this class we have to ensure that icon or assetPath one is given only
class AppModel {
  String title;
  String? assetPath;
  IconData? icon;
  void Function()? onTab;

  Color color;
  Widget? screen;
  String? link;

  AppModel({
    required this.title,
    required this.color,
    this.assetPath,
    this.icon,
    this.link,
    this.onTab,
    this.screen,
  }) : assert(icon == null || assetPath == null);
}
