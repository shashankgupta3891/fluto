import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class JsonFormGenerator extends StatelessWidget {
  const JsonFormGenerator({
    super.key,
    required this.json,
    required this.onChange,
  });

  final dynamic json;
  final ValueChanged<dynamic> onChange;

  @override
  Widget build(BuildContext context) {
    if (json == null) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(json.toString()),
        ),
      );
    }

    if (json is String) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(json.toString()),
        ),
      );
    }

    if (json is int) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(json.toString()),
        ),
      );
    }

    if (json is double) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(json.toString()),
        ),
      );
    }

    if (json is bool) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(json.toString()),
        ),
      );
    }

    if (json is List) {
      var elementList = json as List;

      if (elementList.isEmpty) {
        return const SizedBox(
          width: 0,
          height: 0,
        );
      }

      print(elementList);

      return ListView.builder(
        itemCount: elementList.length,
        itemBuilder: (context, index) {
          final item = elementList[index];
          print(item);
          return ChildJsonGenerator(
            json: item,
            onChange: (value) {},
          );
        },
      );
    }

    if (json is Map) {
      final jsonMapEntryList = (json as Map).entries.toList();
      print(jsonMapEntryList);

      return ListView.builder(
        itemCount: jsonMapEntryList.length,
        itemBuilder: (context, index) {
          final item = jsonMapEntryList[index];
          return ChildJsonGenerator(
            json: item,
            onChange: (value) {},
          );
        },
      );
    }

    return Container();
  }
}

class ChildJsonGenerator extends StatelessWidget {
  final dynamic json;
  final ValueChanged<dynamic> onChange;

  const ChildJsonGenerator({
    super.key,
    required this.json,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    if (json == null) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(json.toString()),
        ),
      );
    }

    if (json is String) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(json.toString()),
        ),
      );
    }

    if (json is int) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(json.toString()),
        ),
      );
    }

    if (json is double) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(json.toString()),
        ),
      );
    }

    if (json is bool) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(json.toString()),
        ),
      );
    }

    if (json is List) {
      var elementList = json as List;
      print("elementList: $elementList");

      if (elementList.isEmpty) return Container();

      return Card(
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          maintainState: true,
          initiallyExpanded: true,
          title: const Text("List"),
          subtitle: Text("Value: $json"),
          children: [
            ...elementList.mapIndexed(
              (index, e) => ChildJsonGenerator(
                json: e,
                onChange: (value) {},
              ),
            ),
            Card(
              color: Colors.blue,
              clipBehavior: Clip.antiAlias,
              child: PopupMenuButton(
                itemBuilder: (context) {
                  return []
                      .map(
                        (e) => PopupMenuItem(
                          value: e,
                          child: Row(
                            children: [
                              Icon(e.icon),
                              const SizedBox(width: 10),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                      .toList();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("List Options"),
                ),
              ),
            )
          ],
        ),
      );
    }

    if (json is Map) {
      var elementList = json as Map;
      print(elementList.entries.length);
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: ExpansionTile(
          maintainState: true,
          initiallyExpanded: true,
          title: const Text("Map"),
          subtitle: Text("Value: ${elementList.toString()}"),
          children: [
            ...elementList.entries.map(
              (e) => ChildJsonGenerator(
                json: e,
                onChange: (value) {},
              ),
            ),
            Card(
              color: Colors.blue,
              clipBehavior: Clip.antiAlias,
              child: PopupMenuButton(
                itemBuilder: (context) {
                  return []
                      .map(
                        (e) => PopupMenuItem(
                          value: e,
                          child: Row(
                            children: [
                              Icon(e.icon),
                              const SizedBox(width: 10),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                      .toList();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("List Options"),
                ),
              ),
            )
          ],
        ),
      );
    }

    if (json is MapEntry) {
      var elementList = json as MapEntry;
      print("elementList: $elementList");

      if (json.value is List) {
        var elementList = json.value as List;
        // print("elementList: $elementList");

        // if (elementList.isEmpty) return Container();

        return Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            maintainState: true,
            initiallyExpanded: true,
            title: Text(json.key.toString()),
            subtitle: Text("Value: ${json.value.toString()}"),
            children: [
              ...elementList.mapIndexed(
                (index, e) => ChildJsonGenerator(
                  json: e,
                  onChange: (value) {},
                ),
              ),
              Card(
                color: Colors.blue,
                clipBehavior: Clip.antiAlias,
                child: PopupMenuButton(
                  itemBuilder: (context) {
                    return []
                        .map(
                          (e) => PopupMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                Icon(e.icon),
                                const SizedBox(width: 10),
                                Text(e.name)
                              ],
                            ),
                          ),
                        )
                        .toList();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("List Options"),
                  ),
                ),
              )
            ],
          ),
        );
      }

      if (json.value is Map) {
        var elementList = json.value as Map;
        print(elementList);
        return Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            maintainState: true,
            initiallyExpanded: true,
            title: Text(json.key.toString()),
            subtitle: Text("Value: ${json.value.toString()}"),
            children: [
              ...elementList.entries.mapIndexed(
                (index, e) => ChildJsonGenerator(
                  json: e,
                  onChange: (value) {},
                ),
              ),
              Card(
                color: Colors.blue,
                clipBehavior: Clip.antiAlias,
                child: PopupMenuButton(
                  itemBuilder: (context) {
                    return []
                        .map(
                          (e) => PopupMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                Icon(e.icon),
                                const SizedBox(width: 10),
                                Text(e.name)
                              ],
                            ),
                          ),
                        )
                        .toList();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("List Options"),
                  ),
                ),
              )
            ],
          ),
        );
      }

      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(elementList.key.toString()),
          subtitle: Text(elementList.value.toString()),
        ),
      );
    }

    return Container();
  }
}
