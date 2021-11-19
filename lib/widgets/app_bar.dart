import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/viewModel/auth_provider.dart';
import '/viewModel/items_provider.dart';

AppBar customAppBar(BuildContext context) {
  final provider = Provider.of<Items>(context, listen: false);
  return AppBar(
    title: Consumer<Items>(
      builder: (context, item, _) {
        return Text(item.path.toUpperCase().toString());
      },
    ),
    actions: [
      PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () async {
                await provider.fetchItems("products");
              },
              child: const Text("Products"),
            ),
            PopupMenuItem(
              onTap: () async {
                await provider.fetchItems("families");
              },
              child: const Text("Families"),
            ),
            PopupMenuItem(
              onTap: () async {
                await provider.fetchItems("locations");
              },
              child: const Text("Locations"),
            ),
            PopupMenuItem(
              onTap: () async {
                await provider.fetchItems("transactions");
              },
              child: const Text("Transactions"),
            ),
          ];
        },
      ),
      IconButton(
        icon: const Icon(Icons.logout_rounded),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Logout'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Provider.of<Auth>(context, listen: false).logout();
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/login", (route) => false);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('No'),
                    ),
                  ],
                );
              });
        },
      ),
    ],
  );
}
