import 'package:flutter/material.dart';
import 'package:login_node_jwt/viewModel/items_provider.dart';
import 'package:provider/provider.dart';

const headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer <ACCESS_TOKEN>'
};

//* ROUTES
const String homeRoute = '/products';
const String loginRoute = '/login';
const String splashRoute = '/splash';
const String registerRoute = '/register';
const String productDetailRoute = '/product-detail';

//* REUSABLE FUNCTIONS
Future<void> refreshProducts(BuildContext context, String path) async {
  await Provider.of<Items>(context, listen: false).fetchItems(path);
}
