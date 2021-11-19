import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/api/auth_api.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  String? get userId => _userId;

  bool? get isAuthenticated {
    return _token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  //* used Future.delayed to delay the future result that will be sent to the main function so that the splashscreen will
  //* be shown for sometime
  Future<bool> autoLogin() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey('userData')) {
        return false;
      }

      final extractedUserData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

      final expiryDate =
          DateTime.parse(extractedUserData['expiryDate'].toString());

      if (expiryDate.isBefore(DateTime.now())) {
        return false;
      }

      _token = extractedUserData['token'];
      _userId = extractedUserData['userId'];
      _expiryDate = expiryDate;

      notifyListeners();
      _autoLogout();
    });
    return true;
  }

  Future<void> signIn(String? email, String? password) async {
    try {
      final response = await AuthApi.signInApi(email!, password!);

      _token = response['access_token'];
      final decodedJwt = JwtDecoder.decode(_token!);

      _userId = decodedJwt["email"];
      _expiryDate = JwtDecoder.getExpirationDate(_token!);

      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final _userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });

      prefs.setString('userData', _userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String? email, String? password) async {
    try {
      await AuthApi.signUpApi(email!, password!);

      // _token = response['access_token'];
      // final decodedJwt = JwtDecoder.decode(_token!);

      // _userId = decodedJwt["email"];
      // _expiryDate = JwtDecoder.getExpirationDate(_token!);

      // _autoLogout();
      notifyListeners();

      // final prefs = await SharedPreferences.getInstance();
      // final _userData = json.encode({
      //   'token': _token,
      //   'userId': _userId,
      //   'expiryDate': _expiryDate!.toIso8601String()
      // });
      // prefs.setString('userData', _userData);
    } catch (error) {
      rethrow;
    }
  }

  void logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');

    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) _authTimer!.cancel();

    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}


// class Auth with ChangeNotifier {
//   String? _token;
//   String? _userId;
//   DateTime? _expiryDate; // to manage when token expires
//   Timer? _authTimer;

//   String? get userId => _userId;

//   String? get token {
//     if (_expiryDate != null &&
//         _expiryDate!.isAfter(DateTime.now()) &&
//         _token != null) {
//       return _token;
//     }
//     return null;
//   }

//   bool? get hasExpired {
//     if (_token != null) {
//       return JwtDecoder.isExpired(_token!);
//     }
//     return null;
//   }

//   bool? get isAuthenticated {
//     return _token != null;
//   }

//   //* used Future.delayed to delay the future result that will be sent to the main function so that the splashscreen will
//   //* be shown for sometime
//   Future<bool?> tryAutoLogin() async {
//     // await Future.delayed(const Duration(seconds: 1), () async {
//     final prefs = await SharedPreferences.getInstance();

//     if (!prefs.containsKey('userData')) {
//       return false;
//     }

//     final extractedUserData =
//         json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

//     final expiryDate =
//         DateTime.parse(extractedUserData['expiryDate'].toString());

//     if (expiryDate.isBefore(DateTime.now())) {
//       return false;
//     }

//     _token = extractedUserData['token'].toString();
//     _userId = extractedUserData['userId'].toString();
//     _expiryDate = expiryDate;

//     notifyListeners();
//     _autoLogout();
//     return true;
//     // });
//   }

//   Future<void> signUp(String? email, String? password) async {
//     try {
//       final response = await AuthApi.signUpApi(email!, password!);

//       _token = response['access_token'];

//       final decodedJwt = JwtDecoder.decode(_token!);

//       _userId = decodedJwt['email'];
//       // _expiryDate = JwtDecoder.getExpirationDate(_token!);

//       _autoLogout();
//       notifyListeners();
//       final prefs = await SharedPreferences.getInstance();
//       final _userData = json.encode({
//         'token': _token,
//         'userId': _userId,
//       });

//       prefs.setString('userData', _userData);
//     } catch (error) {
//       rethrow;
//     }
//   }

//   Future<void> signIn(String? email, String? password) async {
//     try {
//       final response = await AuthApi.signInApi(email!, password!);

//       _token = response['access_token'];

//       final decodedJwt = JwtDecoder.decode(_token!);

//       _userId = decodedJwt["email"];

//       _expiryDate = JwtDecoder.getExpirationDate(_token!);

//       _autoLogout();
//       notifyListeners();

//       final prefs = await SharedPreferences.getInstance();
//       final _userData = json.encode({
//         'token': _token,
//         'userId': _userId,
//         'expiryDate': _expiryDate!.toIso8601String()
//       });

//       prefs.setString('userData', _userData);
//       prefs.setBool("isLoggedIn", true);
//     } catch (error) {
//       rethrow;
//     }
//   }

//   void logout() async {
//     _token = null;
//     _userId = null;
//     _expiryDate = null;

//     final prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//     // prefs.remove('userData');

//     // prefs.setBool("isLoggedIn", false);

//     if (_authTimer != null) {
//       _authTimer!.cancel();
//       _authTimer = null;
//     }

//     notifyListeners();
//   }

//   void _autoLogout() {
//     if (_authTimer != null) _authTimer!.cancel();

//     final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
//     _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
//   }

//   // //* Function that decodes jwt token
//   // String jwtDecoder(String toDecode) {
//   //   String res;
//   //   try {
//   //     while (toDecode.length * 6 % 8 != 0) {
//   //       toDecode += "=";
//   //     }
//   //     res = utf8.decode(base64.decode(toDecode));
//   //   } catch (error) {
//   //     rethrow;
//   //   }
//   //   return res;
//   // }
// }
