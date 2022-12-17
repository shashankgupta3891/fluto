import 'package:fluto/core/pluggable.dart';
import 'package:fluto/core/plugin_manager.dart';
import 'package:fluto/provider/fluto_provider.dart';
import 'package:fluto/ui/screen/plugin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showFlutoBottomSheet(BuildContext context) async {
  final pluginList = PlutoPluginManager.plugins;

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Plugins"),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: pluginList.length,
                itemBuilder: (context, index) {
                  final plugin = pluginList[index];
                  return IconButton(
                    icon: Icon(plugin.iconData),
                    onPressed: () {
                      if (plugin is ManageNagivationKey) {
                        final pluginWithNavigationKey =
                            plugin as ManageNagivationKey;
                        pluginWithNavigationKey
                            .setNagivationKey(provider.navigatorKey);
                      }

                      plugin.onTriggerInit();

                      if (plugin.pluginType == PluginType.screen) {
                        if (plugin.buildWidget != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => plugin.buildWidget!,
                          ));
                        } else {
                          //Show Error message;
                        }
                      } else if (plugin.pluginType == PluginType.widget) {
                        if (plugin.buildWidget != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PluginScreen(pluggable: plugin),
                          ));
                        } else {
                          //Show Error message;
                        }
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
