import 'dart:developer';

import 'package:fluto/src/core/plugin_manager.dart';
import 'package:fluto/src/model/fluto_storage_model.dart';
import 'package:fluto/src/provider/fluto_provider.dart';
import 'package:fluto/src/ui/components/fluto_plugin_sheet.dart';
import 'package:fluto/src/utils/kotlin_touch.dart';
import 'package:fluto_plugin_platform_interface/core/plugin_callback_register.dart';
import 'package:fluto_plugin_platform_interface/fluto_plugin_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/components/screen_wrapper.dart';

class Fluto extends StatefulWidget {
  static TransitionBuilder screenBuilder =
      (context, child) => FlutoScreenWrapper(child: child!);
  const Fluto({
    Key? key,
    required this.child,
    this.wrappedWidgetList = const [],
    required this.navigatorKey,
    this.storage = const NoFlutoStorage(),
  }) : super(key: key);

  final Widget child;
  final List<TransitionBuilder> wrappedWidgetList;

  final GlobalKey<NavigatorState> navigatorKey;
  final FlutoStorage storage;

  @override
  State<Fluto> createState() => _FlutoState();
}

class _FlutoState extends State<Fluto> {
  FlutoStorageModel? _savedData;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final savedData = await widget.storage.load();
    _savedData = savedData?.let((it) => FlutoStorageModel.fromJson(it));

    final pluginList = FlutoPluginRegistrar.pluginList;
    for (final plugin in pluginList) {
      analysePlugin(plugin);
      final pluginRegister = PluginRegister(
        globalNavigatorKey: widget.navigatorKey,
        savePluginData: (final value) async {
          if (_savedData == null) {
            _savedData = FlutoStorageModel(
              setting: {..._savedData?.setting ?? {}},
              pluginInternalData: {
                ..._savedData?.pluginInternalData ?? {},
                ...{plugin.devIdentifier: value}
              },
            );
          } else {
            _savedData?.pluginInternalData?[plugin.devIdentifier] = value;
          }
          _savedData?.toJson().let((it) => widget.storage.save(it));
        },
        loadPluginData: () async {
          return _savedData?.pluginInternalData?[plugin.devIdentifier];
        },
      );
      plugin.setup(pluginRegister: pluginRegister);
    }
  }

  void analysePlugin(Pluggable plugin) {
    //[TODO] Better Plugin Analysis to be added
    try {
      plugin.pluginConfiguration.description;
    } catch (e) {
      log(plugin.devIdentifier, error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    for (final widgetBuilder in widget.wrappedWidgetList.reversed) {
      child = widgetBuilder.call(context, widget.child);
    }

    return ChangeNotifierProvider<FlutoProvider>(
      create: (context) => FlutoProvider(widget.navigatorKey),
      builder: (context, child) {
        final showDialog = context
            .select<FlutoProvider, bool>((value) => value.showButtonSheet);
        if (showDialog) {
          showFlutoBottomSheet(widget.navigatorKey.currentContext!);
        }

        return child ?? Container();
      },
      child: child,
    );
  }
}
