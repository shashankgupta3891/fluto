import 'package:fluto/core/generic_plugins/json_form_generator/json_form_generator.dart';
import 'package:fluto/core/generic_plugins/mock_location/core/fluto_geo_locator_manager.dart';
import 'package:fluto/core/generic_plugins/mock_location/model/location_position_model.dart';
import 'package:fluto/core/pluggable.dart';
import 'package:flutter/material.dart';

class FlutoGenericMockLocationPlugin extends Pluggable {
  FlutoGeoLocatorManager flutoGeoLocatorManager;

  final String uniqueId;

  FlutoGenericMockLocationPlugin(
    this.uniqueId,
    this.flutoGeoLocatorManager,
  );

  @override
  String get id => uniqueId;

  @override
  PluginType get pluginType => PluginType.screen;

  @override
  Widget? get buildWidget => MockLocationPluginScreen(plugin: this);

  @override
  String get displayName => "Location";

  @override
  String get name => "location";

  @override
  void onTriggerInit() {}

  @override
  IconData get iconData => Icons.location_on;
}

class MockLocationPluginScreen extends StatefulWidget {
  final FlutoGenericMockLocationPlugin plugin;
  const MockLocationPluginScreen({
    Key? key,
    required this.plugin,
  }) : super(key: key);

  @override
  State<MockLocationPluginScreen> createState() =>
      _MockLocationPluginScreenState();
}

class _MockLocationPluginScreenState extends State<MockLocationPluginScreen> {
  Position? position;

  @override
  void initState() {
    super.initState();
    position = widget.plugin.flutoGeoLocatorManager.savedPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plugin.displayName),
        actions: [
          Switch.adaptive(
            value: widget.plugin.flutoGeoLocatorManager.isEnable,
            onChanged: widget.plugin.flutoGeoLocatorManager.setEnable,
          )
        ],
      ),
      body: Column(
        children: [
          ValueInputListTile<double?>(
            title: "latitude",
            value: position?.latitude,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  position?.copyWith(latitude: value);
                });
              }
            },
          ),
          ListTile(
            title: const Text("latitude"),
            subtitle: Text(position?.latitude.toString() ?? ""),
          ),
          ListTile(
            title: const Text("latitude"),
            subtitle: Text(position?.latitude.toString() ?? ""),
          ),
          ListTile(
            title: const Text("latitude"),
            subtitle: Text(position?.latitude.toString() ?? ""),
          )
        ],
      ),
    );
  }
}
