import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '/model/error_message.dart';

class ItemApi {
  static const int timeoutDuration = 20;

  static Future fetchAnythingApi(String authToken, String path) async {
    try {
      var url = Uri.parse("http://10.0.2.2:8000/$path");
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      }).timeout(const Duration(seconds: timeoutDuration));

      // print(json.decode(response.body)[0]['name']);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      if (response.statusCode == 401) {
        throw ErrorMessage(json.decode(response.body)['message']);
      }
    } on HttpException {
      throw ErrorMessage("No Internet");
    } on TimeoutException {
      throw ErrorMessage("Problem communicating to server");
    } on SocketException {
      throw ErrorMessage("No Internet");
    } on FormatException {
      throw ErrorMessage("Invalid Format");
    } catch (e) {
      rethrow;
    }
  }

  // static Future addProductApi(
  //     Product product, String authToken, String userId) async {
  //   try {
  //     final url = Uri.parse(BASEURL + "products.json?auth=$authToken");
  //     var response = await http.post(url,
  //         body: json.encode({
  //           'title': product.title,
  //           'description': product.description,
  //           'imageUrl': product.imageUrl,
  //           'price': product.price,
  //           'creatorId': userId
  //         }));

  //     if (response.statusCode == 200) {
  //       return json.decode(response.body);
  //     }

  //     throw json.decode(response.body)['error']; // Error from server
  //   } on HttpException {
  //     throw ErrorMessage("No Internet");
  //   } on SocketException {
  //     throw ErrorMessage("No Internet");
  //   } on FormatException {
  //     throw ErrorMessage("Invalid Format");
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // static Future updateProductApi(
  //     String id, Product product, String authToken) async {
  //   try {
  //     final url = Uri.parse(BASEURL + "products/$id.json?auth=$authToken");
  //     var response = await http.patch(url,
  //         body: json.encode({
  //           'title': product.title,
  //           'description': product.description,
  //           'imageUrl': product.imageUrl,
  //           'price': product.price,
  //           // 'isFavourite': product.isFavourite,
  //         }));

  //     if (response.statusCode == 200) {
  //       return json.decode(response.body);
  //     }

  //     throw json.decode(response.body)['error']; // Error from server
  //   } on HttpException {
  //     throw ErrorMessage("No Internet");
  //   } on SocketException {
  //     throw ErrorMessage("No Internet");
  //   } on FormatException {
  //     throw ErrorMessage("Invalid Format");
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // static Future deleteProductApi(String id, String authToken) async {
  //   try {
  //     final url = Uri.parse(BASEURL + "products/$id.json?auth=$authToken");
  //     var response = await http.delete(url);

  //     if (response.statusCode >= 400) {
  //       throw ErrorMessage("Could not delete product");
  //     }

  //     throw ErrorMessage("Unknown Error"); // Error from server
  //   } on HttpException {
  //     throw ErrorMessage("No Internet");
  //   } on SocketException {
  //     throw ErrorMessage("No Internet");
  //   } on FormatException {
  //     throw ErrorMessage("Invalid Format");
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // static Future toggleFavoriteApi(
  //     String id, String userId, bool status, String authToken) async {
  //   try {
  //     final url =
  //         Uri.parse(BASEURL + "userFavorites/$userId/$id.json?auth=$authToken");
  //     final response = await http.put(url, body: json.encode(status));

  //     print(response);
  //     if (response.statusCode >= 400) {
  //       throw ErrorMessage(
  //           "Could Not Change Favourite Status"); // Error from server
  //     }
  //   } on HttpException {
  //     throw ErrorMessage("No Internet");
  //   } on SocketException {
  //     throw ErrorMessage("No Internet");
  //   } on FormatException {
  //     throw ErrorMessage("Invalid Format");
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
