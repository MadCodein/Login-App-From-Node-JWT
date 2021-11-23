import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/viewModel/items_provider.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Items>(context);

    return ListView.separated(
      itemCount: provider.items.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Text(provider.items[index].id.toString()),
          ),
          title: Text(provider.items[index].name.toString()),
          subtitle: Text("Quantity: ${provider.items[index].quantity}"),
          trailing: Text("Cost: ${provider.items[index].cost}"),
        );
      },
    );
  }
}
