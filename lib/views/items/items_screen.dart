import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants.dart';
import '/widgets/app_bar.dart';
import 'components/item_list.dart';
import '/viewModel/items_provider.dart';

class Item extends StatelessWidget {
  const Item({Key? key}) : super(key: key);

  static const routeName = homeRoute;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Items>(context, listen: false);
    return Scaffold(
      appBar: customAppBar(context),
      body: FutureBuilder(
        future: refreshProducts(context, provider.path),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return RefreshIndicator(
            onRefresh: () => refreshProducts(context, provider.path),
            child: const ProductList(),
          );
        },
      ),
    );
  }
}
