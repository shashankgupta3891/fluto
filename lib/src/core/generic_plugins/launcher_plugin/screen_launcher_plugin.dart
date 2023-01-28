import 'package:fluto_plugin_platform_interface/core/navigation.dart';
import 'package:fluto_plugin_platform_interface/core/pluggable.dart';
import 'package:fluto_plugin_platform_interface/model/plugin_configuration.dart';
import 'package:flutter/material.dart';

class ScreenLauncherPlugin extends Pluggable {
  final Widget screen;
  final String name;
  final IconData icon;
  final String description;

  ScreenLauncherPlugin({
    required super.devIdentifier,
    required this.screen,
    required this.name,
    this.icon = Icons.bug_report,
    this.description = "",
  });

  @override
  Navigation get navigation => Navigation.byScreen(
      globalNavigatorKey: globalNavigatorKey, screen: screen);

  @override
  PluginConfiguration get pluginConfiguration =>
      PluginConfiguration(name: name, icon: icon, description: description);
}
