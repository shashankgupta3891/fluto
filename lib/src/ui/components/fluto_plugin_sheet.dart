import 'package:fluto/src/core/plugin_manager.dart';
import 'package:fluto/src/provider/fluto_provider.dart';
import 'package:fluto_plugin_platform_interface/core/pluggable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showFlutoBottomSheet(BuildContext context) async {
  final pluginList = FlutoPluginRegistrar.pluginList;

  showModalBottomSheet(
    isDismissible: false,
    enableDrag: false,
    context: context,
    builder: (context) {
      final provider = context.read<FlutoProvider>();
      provider.setSheetState(PluginSheetState.clickedAndOpened);
      return WillPopScope(
        onWillPop: () async {
          context.read<FlutoProvider>().setSheetState(PluginSheetState.closed);
          return await Future.value(true);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text("Fluto Project"),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context
                      .read<FlutoProvider>()
                      .setSheetState(PluginSheetState.closed);
                },
                icon: const Icon(Icons.close),
              ),
            ),
            const Divider(),
            Expanded(
              child: Visibility(
                visible: pluginList.isNotEmpty,
                replacement: const Center(child: Text("No Plugin Available")),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: pluginList.length,
                  itemBuilder: (context, index) {
                    final plugin = pluginList[index];

                    return Card(
                      clipBehavior: Clip.antiAlias,
                      color: Color.alphaBlend(
                        Theme.of(context).cardColor,
                        Theme.of(context).secondaryHeaderColor,
                      ),
                      child: FlutoSheetListTile(plugin: plugin),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class FlutoSheetListTile extends StatelessWidget {
  const FlutoSheetListTile({
    Key? key,
    required this.plugin,
  }) : super(key: key);

  final Pluggable plugin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(plugin.pluginConfiguration.icon),
      title: Text(plugin.pluginConfiguration.name),
      subtitle: plugin.pluginConfiguration.description.isNotEmpty
          ? Text(plugin.pluginConfiguration.description)
          : null,
      trailing: ValueListenableBuilder(
        valueListenable: plugin.pluginConfiguration.enable,
        builder: (BuildContext context, bool value, Widget? child) {
          return Switch.adaptive(
            value: value,
            onChanged: (value) =>
                plugin.pluginConfiguration.enable.value = value,
          );
        },
      ),
      onTap: () {
        plugin.navigation.onLaunch.call();
      },
    );
  }
}
