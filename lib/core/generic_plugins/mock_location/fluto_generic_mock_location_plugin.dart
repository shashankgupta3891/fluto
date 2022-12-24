import 'package:fluto/core/generic_plugins/mock_location/core/fluto_geo_locator_manager.dart';
import 'package:fluto/core/generic_plugins/mock_location/model/location_position_model.dart';
import 'package:fluto/core/pluggable.dart';
import 'package:flutter/material.dart';

import '../json_form_generator/json_form_generator_new.dart';

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

      body: JsonFormGenerator(
        json: jsonDemo1,
        onChange: (value) {
          print(value);
        },
      ),

      // body: Column(
      //   children: [
      //     // ValueInputListTile<double?>(
      //     //   jsonKey: "latitude",
      //     //   jsonValue: position?.latitude,
      //     //   onChanged: (value) {
      //     //     if (value != null) {
      //     //       setState(() {
      //     //         position?.copyWith(latitude: value);
      //     //       });
      //     //     }
      //     //   },
      //     // ),
      //     ListTile(
      //       title: const Text("latitude"),
      //       subtitle: Text(position?.latitude.toString() ?? ""),
      //     ),
      //     ListTile(
      //       title: const Text("latitude"),
      //       subtitle: Text(position?.latitude.toString() ?? ""),
      //     ),
      //     ListTile(
      //       title: const Text("latitude"),
      //       subtitle: Text(position?.latitude.toString() ?? ""),
      //     )
      //   ],
      // ),
    );
  }
}

const jsonDemo1 = {
  "hello": "hhe",
  "hey": true,
  "integer": 37,
  "double_float": 23.23,
  "array_array": [],
  "array_array_with_value": [
    "afsad",
    "asdf",
    {
      "34": 2,
    }
  ],
  "nullll": null,
  "empty_object": {},
  "filled_object": {
    "key1": "39",
    "key2": 93,
    "list": [],
    "list2": [2, 5, 2, 2]
  }
};

const jsonDemo2 = [
  "afsad",
  "asdf",
  1,
  4.7,
  null,
  [],
  {
    "34": 2,
  }
];
