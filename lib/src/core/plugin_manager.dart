import 'package:fluto_plugin_platform_interface/fluto_plugin_platform_interface.dart';

abstract class FlutoPluginManager {
  static final List<Pluggable> _plugins = [];

  static List<Pluggable> get plugins => _plugins;

  static void registerPlugin(Pluggable plugin) {
    _plugins.add(plugin);
  }

  static void unregisterPlugin(Pluggable plugin) {
    _plugins.remove(plugin);
  }

  static void unregisterAllPlugins() {
    _plugins.clear();
  }

  static void registerAllPlugins([List<Pluggable>? plugins]) {
    if (plugins != null) {
      _plugins.addAll(plugins);
    }
  }
}
