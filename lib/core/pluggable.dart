import 'package:flutter/widgets.dart';

abstract class Pluggable {
  String get id;
  String get name;
  String get displayName;
  void onTriggerInit();
  Widget? get buildWidget;
  IconData get iconData;
  PluginType get pluginType;
}

abstract class EnableAble {
  bool get isEnable;
  void setEnable(bool isEnable);
}

abstract class ManageNagivationKey {
  setNagivationKey(GlobalKey<NavigatorState> key);
}

class Plugin {
  Plugin({
    this.widget,
    required this.pluginType,
  });

  final Widget? widget;

  factory Plugin.screen({
    required Widget widget,
  }) {
    return Plugin(
      pluginType: PluginType.screen,
      widget: widget,
    );
  }

  factory Plugin.widget({
    required Widget widget,
  }) {
    return Plugin(
      pluginType: PluginType.widget,
      widget: widget,
    );
  }

  final PluginType pluginType;
}

enum PluginType {
  screen,
  widget,
  onTap,
}
