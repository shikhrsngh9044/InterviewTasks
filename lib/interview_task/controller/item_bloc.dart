import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../utils/constants.dart';
import '../model/item.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemState()) {
    on<GetItems>((event, emit) {
      final box = Hive.box("items");
      List<ItemModel> items = [];
      List<dynamic> values = box.values.toList();

      if (values.isEmpty) {
        box.addAll(itemsList.map((e) => e.toMap()).toList());
        items = itemsList;
      } else {
        items = values.map((e) {
          final Map<String, dynamic> map = jsonDecode(jsonEncode(e));
          return ItemModel.fromMap(map);
        }).toList();
      }

      emit(ItemState(items: items));
    });

    on<AddItem>((event, emit) async {
      final box = Hive.box("items");
      await box.add(event.item.toMap());
      List<ItemModel> items = [];
      List<dynamic> values = box.values.toList();

      if (values.isNotEmpty) {
        items = values.map((e) {
          final Map<String, dynamic> map = jsonDecode(jsonEncode(e));
          return ItemModel.fromMap(map);
        }).toList();
      }

      emit(ItemState(items: items));
    });

    on<SortList>((event, emit) {
      List<ItemModel> items = (state.items ?? []).where((_) => true).toList();
      if (event.sortType == SortType.byName) {
        items = items
          ..sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      }
      if (event.sortType == SortType.byPrice) {
        items = items..sort((a, b) => a.price.compareTo(b.price));
      }
      if (event.sortType == SortType.byDate) {
        items = items..sort((a, b) => a.date.compareTo(b.date));
      }

      emit(ItemState(items: items));
    });
  }
}

final itemsList = [
  ItemModel(
    name: "Apple",
    price: 20.5,
    date: DateTime(2022, 10, 23).toString(),
  ),
  ItemModel(
    name: "Orange",
    price: 10.5,
    date: DateTime(2022, 10, 21).toString(),
  ),
  ItemModel(
    name: "Pineapple",
    price: 25.5,
    date: DateTime(2022, 10, 22).toString(),
  ),
];
