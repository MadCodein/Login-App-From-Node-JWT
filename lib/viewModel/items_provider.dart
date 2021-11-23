import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/api/item_api.dart';
import '/model/product_model.dart';

class Items with ChangeNotifier {
  List<ItemModel> _items = [];
  String _path = "products";

  // this [..._items] is a reference to the original list or copy of the orginal list
  List<ItemModel> get items => [..._items];

  String get path => _path;

  // function fetchs product
  Future<void> fetchItems(String route) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final extractedUserData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

      final _token = extractedUserData['token'].toString();

      var response = await ItemApi.fetchAnythingApi(_token, route);
      final List<ItemModel> loadedProducts = [];

      if (response == null) return;

      for (var response in response) {
        loadedProducts.add(ItemModel.fromJson(response));
      }

      _path = route;
      _items = loadedProducts;
    } catch (error) {
      rethrow;
    }

    notifyListeners();
  }

  // function adds a product to the list
  // Future<void> addProduct(Product product) async {
  //   try {
  //     var response =
  //         await PRODUCT_API.addProductApi(product, _authToken!, _userId!);

  //     final newProduct = Product(
  //       id: response['name'],
  //       title: product.title,
  //       description: product.description,
  //       price: product.price,
  //       imageUrl: product.imageUrl,
  //     );
  //     _products.add(newProduct);
  //     // _products.insert(0, element)
  //   } catch (error) {
  //     rethrow;
  //   }

  //   notifyListeners();
  // }

  // Future<void> updateProduct(String prodId, Product newProduct) async {
  //   try {
  //     final productIndex =
  //         _products.indexWhere((product) => product.id == prodId);
  //     if (productIndex >= 0) {
  //       await PRODUCT_API.updateProductApi(prodId, newProduct, _authToken!);

  //       _products[productIndex] = newProduct;
  //       notifyListeners();
  //     } else {
  //       print('...');
  //     }
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // Future<void> deleteProduct(String prodId) async {
  //   //* find existing product
  //   final _existingProductIndex =
  //       _products.indexWhere((prod) => prod.id == prodId);
  //   Product? _existingProduct = _products[_existingProductIndex];
  //   _products.removeAt(_existingProductIndex);
  //   notifyListeners();

  //   //* call the delete api if it succeeds assign null to _existingProduct variable
  //   //* if it does not succeed, reinsert that product into the _products list
  //   try {
  //     await PRODUCT_API.deleteProductApi(prodId, _authToken!);
  //     _existingProduct = null;
  //   } catch (error) {
  //     _products.insert(_existingProductIndex, _existingProduct!);
  //     notifyListeners();
  //     rethrow;
  //   }
  //   // await API.deleteProductApi(prodId).then(
  //   //   (_) {
  //   //     _existingProduct = null;
  //   //   },
  //   // ).catchError(
  //   //   (error) {
  //   //     _products.insert(_existingProductIndex, _existingProduct!);
  //   //     notifyListeners();
  //   //     throw error;
  //   //   },
  //   // );
  // }

  // Future<void> toggleFavouriteStatus(String prodId, bool status) async {
  //   // final _existingProductIndex =
  //   //     _products.indexWhere((prod) => prod.id == prodId);
  //   // var _oldStatus = _products[_existingProductIndex].isFavourite;

  //   try {
  //     await PRODUCT_API.toggleFavoriteApi(
  //         prodId, _userId!, status, _authToken!);
  //   } catch (error) {
  //     rethrow;
  //   }
  //   notifyListeners();
  // }

  // // function to find a product by id
  // Product findById(String id) {
  //   return _products.firstWhere((prod) => prod.id == id);
  // }
}
