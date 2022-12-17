import 'package:flutter/material.dart';

class JsonEditor extends StatelessWidget {
  final Map<String, dynamic> json;

  const JsonEditor({super.key, required this.json});

  @override
  Widget build(BuildContext context) {
    final jsonMapEntryList = json.entries.toList();

    return ListView.builder(
      itemCount: jsonMapEntryList.length,
      itemBuilder: (context, index) {
        final item = jsonMapEntryList[index];
        return ValueInputListTile(
          jsonKey: item.key,
          jsonValue: item.value,
          onChanged: (final value) {},
        );
      },
    );
  }
}

class ValueInputListTile<T> extends StatelessWidget {
  const ValueInputListTile({
    Key? key,
    required this.jsonKey,
    required this.jsonValue,
    required this.onChanged,
  }) : super(key: key);

  final String jsonKey;
  final T jsonValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
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
              final result =
                  await showValueEditDialog(context, jsonKey, jsonValue);
              if (result != null) onChanged.call(result);
            }
          },
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
      return StatefulBuilder(
        builder: (context, setState) {
          var newValue = value;
          return AlertDialog(
            title: Text("Edit $valueName"),
            content: TextFormField(
              initialValue: newValue.toString(),
              onChanged: (val) {
                if (newValue is double?) {
                  newValue = double.tryParse(val.toString()) as T?;
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

enum JsonEditOptionType {
  edit(Icons.edit),
  delete(Icons.delete);

  const JsonEditOptionType(this.icon);
  final IconData icon;
}
