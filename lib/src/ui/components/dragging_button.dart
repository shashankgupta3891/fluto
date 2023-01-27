import 'package:draggable_widget/draggable_widget.dart';
import 'package:fluto/src/provider/fluto_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DraggingButton extends StatelessWidget {
  const DraggingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flutoProvider = context.read<FlutoProvider>();
    final showDraggingButton = context
        .select<FlutoProvider, bool>((value) => value.showDraggingButton);
    return DraggableWidget(
      bottomMargin: 80,
      topMargin: 80,
      intialVisibility: showDraggingButton,
      horizontalSpace: 20,
      shadowBorderRadius: 50,
      initialPosition: AnchoringPosition.bottomRight,
      dragController: flutoProvider.dragController,
      child: ElevatedButton(
        child: const Text("Launch Fluto"),
        onPressed: () {
          flutoProvider.setSheetState(PluginSheetState.clicked);
        },
      ),
    );
  }
}
