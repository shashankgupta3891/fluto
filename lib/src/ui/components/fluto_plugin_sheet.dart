import 'package:fluto/src/core/plugin_manager.dart';
import 'package:fluto/src/provider/fluto_provider.dart';
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
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: Text("Plugins"),
            // ),
            // SizedBox(
            //   height: 50,
            //   child:  ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // shrinkWrap: true,
                // scrollDirection: Axis.horizontal,
                itemCount: pluginList.length,
                itemBuilder: (context, index) {
                  final plugin = pluginList[index];

                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      dense: true,
                      leading: Icon(plugin.pluginConfiguration.icon),
                      title: Text(plugin.pluginConfiguration.name),
                      subtitle: Text(plugin.pluginConfiguration.description),
                      onTap: () {
                        plugin.setup(provider.navigatorKey);
                        plugin.navigation.onLaunch.call();
                      },
                    ),
                  );
                  // return IconButton(
                  //   icon: Icon(plugin.pluginConfiguration.icon),
                  //   onPressed: () {
                  //     plugin.setup(provider.navigatorKey);
                  //     plugin.navigation.onLaunch.call();
                  //   },
                  // );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
