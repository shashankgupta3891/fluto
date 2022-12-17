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
          title: item.key,
          value: item.value,
          onChanged: (dynamic value) {},
        );
      },
    );
  }
}

class ValueInputListTile<T> extends StatelessWidget {
  const ValueInputListTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text("Value: $value"),
        trailing: PopupMenuButton<int>(
          itemBuilder: (context) => [
            // popupmenu item 1
            PopupMenuItem(
              value: 1,
              // row has two child icon and text.
              child: Row(
                children: const [
                  Icon(Icons.star),
                  SizedBox(
                    // sized box with width 10
                    width: 10,
                  ),
                  Text("Get The App")
                ],
              ),
            ),
            // popupmenu item 2
            PopupMenuItem(
              value: 2,
              // row has two child icon and text
              child: Row(
                children: const [
                  Icon(Icons.chrome_reader_mode),
                  SizedBox(
                    // sized box with width 10
                    width: 10,
                  ),
                  Text("About")
                ],
              ),
            ),
          ],
          offset: const Offset(0, 100),
          color: Colors.grey,
          elevation: 2,
        ),
        onTap: () async {
          final result = await showValueEditDialog(context, title, value);
          if (result != null) onChanged.call(result);
        },
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
