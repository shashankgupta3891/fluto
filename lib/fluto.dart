import 'package:fluto/ui/components/fluto_plugin_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/fluto_provider.dart';

class Fluto extends StatefulWidget {
  const Fluto({
    Key? key,
    required this.child,
    required this.navigatorKey,
    this.wrappedWidgetList = const [],
  }) : super(key: key);

  final Widget child;
  final List<TransitionBuilder> wrappedWidgetList;

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<Fluto> createState() => _FlutoState();
}

class _FlutoState extends State<Fluto> {
  @override
  void initState() {
    super.initState();
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
