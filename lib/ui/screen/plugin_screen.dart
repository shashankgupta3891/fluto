import 'package:fluto/core/pluggable.dart';
import 'package:flutter/material.dart';

class PluginScreen extends StatelessWidget {
  const PluginScreen({super.key, required this.pluggable});

  final Pluggable pluggable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pluggable.displayName),
      ),
      body: pluggable.buildWidget,
    );
  }
}
