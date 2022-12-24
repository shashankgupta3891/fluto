import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

typedef Json = Map<String, dynamic>;

class JsonEditor extends StatelessWidget {
  final Json json;
  final ValueChanged<Json> onChange;

  const JsonEditor({super.key, required this.json, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final jsonMapEntryList = json.entries.toList();

    return ListView.builder(
      itemCount: jsonMapEntryList.length,
      itemBuilder: (context, index) {
        final item = jsonMapEntryList[index];
        return JsonEntryListTile(
          jsonKey: item.key,
          jsonValue: item.value,
          onEdit: () async {
            final result =
                await showValueEditDialog(context, item.key, item.value);
            print("result: $result");

            final newMap = {
              ...json,
              ...{item.key: result}
            };
            onChange.call(newMap);
          },
          onDelete: () {
            final newMap = {
              ...json,
            }..remove(item.key);
            onChange.call(newMap);
          },
          onChange: (value) async {
            print("result: $value");

            final newMap = {
              ...json,
              ...{item.key: value}
            };
            onChange.call(newMap);
          },
        );
      },
    );
  }
}

class JsonEntryListTile<T> extends StatelessWidget {
  const JsonEntryListTile({
    Key? key,
    required this.jsonKey,
    required this.jsonValue,
    required this.onEdit,
    required this.onDelete,
    required this.onChange,
  }) : super(key: key);

  final String jsonKey;
  final T jsonValue;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<T> onChange;

  @override
  Widget build(BuildContext context) {
    // print(jsonKey);
    // print(jsonValue.runtimeType);
    // print("isMap");
    // print(jsonValue is Map);

    if (jsonValue is List) {
      print("Iterable");
      return ListTypeListTile(
        jsonKey: jsonKey,
        jsonValue: jsonValue,
        onChange: (value) {
          onChange.call(value);
        },
        onDelete: onDelete,
        onEdit: onEdit,
      );

      // var elementList = jsonValue as List;

      // return Card(
      //   clipBehavior: Clip.antiAlias,
      //   child: ExpansionTile(
      //     maintainState: true,
      //     initiallyExpanded: true,
      //     title: Text(jsonKey),
      //     subtitle: Text("Value: $jsonValue"),
      //     children: [
      //       ...elementList.mapIndexed(
      //         (index, e) => ListItemEntryTile(
      //           value: e,
      //           onSelectOption: (final option) async {
      //             if (option == ListItemEditOptionType.edit) {
      //               final result = await showValueEditDialog(
      //                 context,
      //                 "Index:$index",
      //                 e,
      //               );
      //               print("result: $result");

      //               final newList = [...elementList]
      //                 ..insert(index, result)
      //                 ..removeAt(index + 1);

      //               onChange.call(newList as T);
      //             } else if (option == ListItemEditOptionType.delete) {
      //               final newList = [...elementList]..removeAt(index);

      //               onChange.call(newList as T);
      //             } else if (option == ListItemEditOptionType.swap) {
      //               final resultIndex = await showGetIntDialog(context);
      //               if (resultIndex != null) {
      //                 final newList = [...elementList]
      //                   ..swap(index, resultIndex);
      //                 onChange.call(newList as T);
      //               }
      //             }
      //           },
      //         ),
      //       ),
      //       Card(
      //         color: Colors.blue,
      //         clipBehavior: Clip.antiAlias,
      //         child: PopupMenuButton(
      //           itemBuilder: (context) {
      //             return ListEditOptionType.values
      //                 .map(
      //                   (e) => PopupMenuItem(
      //                     value: e,
      //                     child: Row(
      //                       children: [
      //                         Icon(e.icon),
      //                         const SizedBox(width: 10),
      //                         Text(e.name)
      //                       ],
      //                     ),
      //                   ),
      //                 )
      //                 .toList();
      //           },
      //           child: const Padding(
      //             padding: EdgeInsets.all(8.0),
      //             child: Text("List Options"),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // );

    }

    if (jsonValue is Map) {
      print("It is Map");
      return MapTypeListTile(
        jsonKey: jsonKey,
        jsonValue: jsonValue,
        onChange: (value) {
          onChange.call(value);
        },
        onDelete: onDelete,
        onEdit: onEdit,
      );
    }

    return Card(
      child: ListTile(
        title: Text(jsonKey),
        subtitle: Text("Value: $jsonValue"),
        trailing: PopupMenuButton<JsonEditOptionType>(
          itemBuilder: (context) {
            return JsonEditOptionType.values
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
          onSelected: (val) async {
            if (val == JsonEditOptionType.edit) {
              onEdit.call();
            } else if (val == JsonEditOptionType.delete) {
              onDelete.call();
            }
          },
        ),
      ),
    );
  }
}

class ListTypeListTile extends StatelessWidget {
  const ListTypeListTile({
    super.key,
    required this.jsonValue,
    required this.jsonKey,
    required this.onEdit,
    required this.onDelete,
    required this.onChange,
  });
  final String jsonKey;
  final dynamic jsonValue;

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged onChange;

  @override
  Widget build(BuildContext context) {
    var elementList = jsonValue as List;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        maintainState: true,
        initiallyExpanded: true,
        title: Text(jsonKey),
        subtitle: Text("Value: $jsonValue"),
        children: [
          ...elementList.mapIndexed(
            (index, e) => ListItemEntryTile(
              value: e,
              onSelectOption: (final option) async {
                if (option == ListItemEditOptionType.edit) {
                  final result = await showValueEditDialog(
                    context,
                    "Index:$index",
                    e,
                  );
                  print("result: $result");

                  final newList = [...elementList]
                    ..insert(index, result)
                    ..removeAt(index + 1);

                  onChange.call(newList);
                } else if (option == ListItemEditOptionType.delete) {
                  final newList = [...elementList]..removeAt(index);

                  onChange.call(newList);
                } else if (option == ListItemEditOptionType.swap) {
                  final resultIndex = await showGetIntDialog(context);
                  if (resultIndex != null) {
                    final newList = [...elementList]..swap(index, resultIndex);
                    onChange.call(newList);
                  }
                }
              },
            ),
          ),
          Card(
            color: Colors.blue,
            clipBehavior: Clip.antiAlias,
            child: PopupMenuButton(
              itemBuilder: (context) {
                return ListEditOptionType.values
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
}

class MapTypeListTile extends StatelessWidget {
  const MapTypeListTile({
    super.key,
    required this.jsonKey,
    required this.jsonValue,
    required this.onEdit,
    required this.onDelete,
    required this.onChange,
  });
  final String jsonKey;
  final dynamic jsonValue;

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged onChange;

  @override
  Widget build(BuildContext context) {
    var elementList = (jsonValue as Map).entries;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        maintainState: true,
        initiallyExpanded: true,
        title: Text(jsonKey),
        subtitle: Text("Value: $jsonValue"),
        children: [
          ...elementList.mapIndexed(
            (index, e) => JsonEntryListTile(
              jsonKey: e.key, jsonValue: e.value, onChange: (final value) {},
              onDelete: () {}, onEdit: () {},

              // value: e,
              // onSelectOption: (final option) async {
              //   if (option == ListItemEditOptionType.edit) {
              //     final result = await showValueEditDialog(
              //       context,
              //       "Index:$index",
              //       e,
              //     );
              //     print("result: $result");

              //     final newList = [...elementList]
              //       ..insert(index, result)
              //       ..removeAt(index + 1);

              //     onChange.call(newList);
              //   } else if (option == ListItemEditOptionType.delete) {
              //     final newList = [...elementList]..removeAt(index);

              //     onChange.call(newList);
              //   } else if (option == ListItemEditOptionType.swap) {
              //     final resultIndex = await showGetIntDialog(context);
              //     if (resultIndex != null) {
              //       final newList = [...elementList]
              //         ..swap(index, resultIndex);
              //       onChange.call(newList);
              //     }
              //   }
              // },
            ),
          ),
          Card(
            color: Colors.blue,
            clipBehavior: Clip.antiAlias,
            child: PopupMenuButton(
              itemBuilder: (context) {
                return ListEditOptionType.values
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
}

class ListItemEntryTile extends StatelessWidget {
  final dynamic value;
  final ValueChanged<ListItemEditOptionType> onSelectOption;
  const ListItemEntryTile(
      {super.key, this.value, required this.onSelectOption});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(value.toString()),
        trailing: PopupMenuButton<ListItemEditOptionType>(
          itemBuilder: (context) {
            return ListItemEditOptionType.values
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
          onSelected: onSelectOption.call,
        ),
      ),
    );
  }
}

Future<T?> showValueEditDialog<T>(
    BuildContext context, String valueName, T? value) async {
  return showDialog(
    context: context,
    builder: (context) {
      var newValue = value;
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Edit $valueName"),
            content: newValue is bool
                ? Switch.adaptive(
                    value: newValue as bool,
                    onChanged: (value) {
                      setState(() {
                        newValue = value as T;
                      });
                    },
                  )
                : TextFormField(
                    initialValue: newValue.toString(),
                    onChanged: (val) {
                      if (newValue is double?) {
                        newValue = double.tryParse(val.toString()) as T?;
                      } else {
                        newValue = val as T?;
                      }
                    },
                  ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop<T>(context, newValue);
                },
                child: const Text("Change"),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<int?> showGetIntDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      int? newValue;
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Replace with Index"),
            content: TextFormField(
              initialValue: newValue?.toString() ?? "",
              onChanged: (val) {
                newValue = int.tryParse(val);
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop<int?>(context, newValue);
                },
                child: const Text("Change"),
              ),
            ],
          );
        },
      );
    },
  );
}

enum JsonEditOptionType {
  edit(Icons.edit),
  delete(Icons.delete);

  const JsonEditOptionType(this.icon);
  final IconData icon;
}

enum ListItemEditOptionType {
  edit(Icons.edit),
  delete(Icons.delete),
  swap(Icons.swap_vert);

  const ListItemEditOptionType(this.icon);
  final IconData icon;
}

enum ListEditOptionType {
  addItem(Icons.add),
  addItemAt(Icons.add),
  deleteAll(Icons.delete);

  const ListEditOptionType(this.icon);
  final IconData icon;
}
