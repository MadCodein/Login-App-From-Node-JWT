import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '/constants.dart';
import '/model/error_message.dart';

// ignore: camel_case_types
class AuthApi {
  static Future signUpApi(
    String email,
    String password,
  ) async {
    try {
      final url = Uri.parse("http://10.0.2.2:8000/auth/register");

      var response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      //* Success
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      //! Error handling
      if (response.statusCode == 401) {
        return throw ErrorMessage(json.decode(response.body)['message']);
      }
    } on HttpException {
      throw ErrorMessage("No Internet");
    } on SocketException {
      throw ErrorMessage("No Internet");
    } on FormatException {
      throw ErrorMessage("Invalid Format");
    } catch (e) {
      rethrow;
    }
  }

  static Future signInApi(String email, String password) async {
    try {
      final url = Uri.parse("http://10.0.2.2:8000/auth/login");

      var response = await http.post(url,
          headers: headers,
          body: json.encode(
            {
              "email": email,
              "password": password,
            },
          ));
      // print(response.body);
      //* Success
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      //! Error handling
      if (response.statusCode == 401) {
        return throw ErrorMessage(json.decode(response.body)['message']);
      }
    } on HttpException {
      throw ErrorMessage("No Internet");
    } on SocketException {
      throw ErrorMessage("No Internet");
    } on FormatException {
      throw ErrorMessage("Invalid Format");
    } on PlatformException {
      throw ErrorMessage("An error occurred, please check your credentials!");
    } catch (e) {
      rethrow;
    }
  }
}
