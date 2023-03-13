import 'package:fluto/src/ui/components/dragging_button.dart';
import 'package:flutter/material.dart';

class FlutoScreenWrapper extends StatelessWidget {
  const FlutoScreenWrapper({
    super.key,
    this.builder,
    required this.child,
  });

  final TransitionBuilder? builder;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    /// A drag controller to show/hide or move the widget around the screen

    final newChild = builder?.call(context, child) ?? child;

    return Scaffold(
      body: Stack(
        children: [
          newChild,
          const DraggingButton(),
        ],
      ),
    );
  }
}
