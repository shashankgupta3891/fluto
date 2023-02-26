import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:example/core/fluto/fluto_storage.dart';
import 'package:example/core/fluto/plugin.dart';
import 'package:fluto/fluto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

FlutoDynamicBaseUrlManager flutoDynamicBaseUrlManager =
    FlutoDynamicBaseUrlManager(() async {
  return "http://www.salfjas.asfjl";
});

class FlutoHTTPClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    Uri.tryParse("https://www.google.com");
    // request.url.resolveUri(reference)
    // request.url.replace();
    // request.url.host
    throw UnimplementedError();
  }
}

Uri url = Uri();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // options.copyWith()
      // options.copyWith(baseUrl: "baseUrl");
      // handler.next(options);
      // options.
    },
  ));

  var url = Uri.https('example.com', 'whatsit/create');
  var response =
      await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  final http.Client client = http.Client();

  // client.send(request)

  await setupSharedPreference();
  await setupFlutterSecureStorage();
  FlutoPluginRegistrar.registerAllPlugins([
    ScreenLauncherPlugin(
      devIdentifier: 'one',
      screen: Scaffold(
        appBar: AppBar(title: const Text("first screen")),
        body: const Text("first screen"),
      ),
      name: "first screen",
    ),
    StorageTestPlugin(devIdentifier: "storage_test"),
    FlutoDynamicBaseUrlPlugin(
      devIdentifier: 'base_url_change',
      flutoDynamicBaseUrlManager: flutoDynamicBaseUrlManager,
    )
  ]);

  runApp(Fluto(
    navigatorKey: navigatorKey,
    storage: SharedPreferencesFlutoStorage(),
    child: const MyApp(),
  ));
}

Future<void> setupFlutterSecureStorage() async {
// Create storage
  const storage = FlutterSecureStorage();

// Save an integer value to 'counter' key.
  await storage.write(key: 'counter', value: "1302");
// Save an boolean value to 'repeat' key.
  await storage.read(key: 'repeat');
}

Future<void> setupSharedPreference() async {
  try {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

// Save an integer value to 'counter' key.
    await prefs.setInt('counter', 10);
// Save an boolean value to 'repeat' key.
    await prefs.setBool('repeat', true);
// Save an double value to 'decimal' key.
    await prefs.setDouble('decimal', 1.5);
// Save an String value to 'action' key.
    await prefs.setString('action', 'Start');
// Save an list of strings to 'items' key.
    await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
  } catch (e, s) {
    log("SharedPref Init", error: e, stackTrace: s);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      builder: (context, child) => FlutoScreenWrapper(child: child!),
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    context.showFlutoSheet();
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
