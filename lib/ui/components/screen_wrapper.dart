import 'package:fluto/ui/components/dragging_button.dart';
import 'package:flutter/material.dart';

class FlutoScreenWrapper extends StatelessWidget {
  const FlutoScreenWrapper({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    /// A drag controller to show/hide or move the widget around the screen

    return Scaffold(
      body: Stack(
        children: [
          child,
          const DraggingButton(),
        ],
      ),
    );
  }
}
