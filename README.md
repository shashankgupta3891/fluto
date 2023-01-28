# fluto

Fluto is an on-device debugging framework for Flutter applications, which helps in the inspection of HTTP requests/responses, captures Crashes, and ANRs, and manipulates application data on the go.

You can create your own plugin by extended from `Pluggable` abstract class available in [fluto_plugin_platform_interface](https://github.com/shashankgupta3891/fluto_plugin_platform_interface)

It comes with a UI to monitor and share the information, as well as APIs to access and use that information in your application.

## Sample usage:

```dart
void main() {
  FlutoPluginManager.registerAllPlugins([
    ScreenLauncherPlugin(
      devIdentifier: 'one',
      screen: Scaffold(
        appBar: AppBar(title: const Text("first screen")),
        body: const Text("first screen"),
      ),
      name: "first screen",
    )
  ]);

  runApp(Fluto(navigatorKey: navigatorKey, child: const MyApp()));
}
```


## Issues

Please file any issues, bugs or feature requests as an issue on our [GitHub](https://github.com/shashankgupta3891/fluto/issues) page. Commercial support is available, you can contact us at <shashankgupta3891@gmail.com>.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please send us your [pull request](https://github.com/shashankgupta3891/fluto/pulls).

## Author


This Geolocator plugin for Flutter is developed by [Shashank Gupta](https://github.com/shashankgupta3891).