import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants.dart';
import '../controller/item_bloc.dart';
import '../model/item.dart';
import 'item_form.dart';

class InterTask extends StatelessWidget {
  const InterTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemBloc()..add(GetItems()),
      child: const InterTaskUI(),
    );
  }
}

class InterTaskUI extends StatelessWidget {
  const InterTaskUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item list"),
        actions: [
          PopupMenuButton(
            child: const Icon(Icons.sort),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    context.read<ItemBloc>().add(SortList(SortType.byName));
                  },
                  child: const Text("By name"),
                ),
                PopupMenuItem(
                  onTap: () {
                    context.read<ItemBloc>().add(SortList(SortType.byPrice));
                  },
                  child: const Text("By price"),
                ),
                PopupMenuItem(
                  onTap: () {
                    context.read<ItemBloc>().add(SortList(SortType.byDate));
                  },
                  child: const Text("By date"),
                ),
              ];
            },
          )
        ],
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.items?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.items![index].name),
                        subtitle: Text(DateTime.parse(state.items![index].date)
                            .getFormattedDateString),
                        trailing: Text(state.items![index].price.toString()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () async {
                    final _itemModel = await Navigator.push<ItemModel>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ItemForm(),
                      ),
                    );

                    if (_itemModel != null) {
                      context.read<ItemBloc>().add(AddItem(_itemModel));
                    }
                  },
                  child: const Text("Add Item"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
