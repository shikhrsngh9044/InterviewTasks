import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../model/item.dart';

class ItemForm extends StatelessWidget {
  const ItemForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ItemFormUI();
  }
}

class ItemFormUI extends StatefulWidget {
  const ItemFormUI({Key? key}) : super(key: key);

  @override
  State<ItemFormUI> createState() => _ItemFormUIState();
}

class _ItemFormUIState extends State<ItemFormUI> {
  late ItemModel _itemModel;

  @override
  void initState() {
    _itemModel = ItemModel(name: "", price: 0.0, date: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item")),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: "eg: Plum",
                labelText: "Item Name",
              ),
              onChanged: (str) {
                if (str.trim().isNotEmpty) {
                  _itemModel = _itemModel.copyWith(name: str.trim());
                }
              },
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "eg: 3.5",
                labelText: "Item Price",
              ),
              onChanged: (str) {
                if (str.trim().isNotEmpty) {
                  _itemModel = _itemModel.copyWith(
                      price: double.tryParse(str.trim()) ?? 0.0);
                }
              },
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: _itemModel.date.isEmpty
                    ? "eg: 21/10/2022"
                    : DateTime.parse(_itemModel.date).getFormattedDateString,
                labelText: "Item Date",
              ),
              onTap: () async {
                final dateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022, 1, 1),
                  lastDate: DateTime(2022, 12, 31),
                );

                if (dateTime != null) {
                  _itemModel = _itemModel.copyWith(date: dateTime.toString());
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 25.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _itemModel);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
