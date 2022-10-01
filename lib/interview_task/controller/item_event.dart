part of 'item_bloc.dart';

@immutable
abstract class ItemEvent {}

class GetItems extends ItemEvent {}

class AddItem extends ItemEvent {
  final ItemModel item;

  AddItem(this.item);
}

class SortList extends ItemEvent {
  final SortType sortType;

  SortList(this.sortType);
}
