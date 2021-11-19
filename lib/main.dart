import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/viewModel/auth_provider.dart';
import '/viewModel/items_provider.dart';
import '/views/auth/login_screen.dart';
import '/views/auth/register_screen.dart';
import '/views/items/items_screen.dart';
import '/views/splashscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Items()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          return MaterialApp(
            key: Key('auth_${auth.isAuthenticated}'),
            // initialRoute: auth.isAuthenticated! ? homeRoute : splashRoute,
            // home: auth.isAuthenticated! ? const Item() : const SplashScreen(),
            home: auth.isAuthenticated!
                ? const Item()
                : FutureBuilder(
                    future: auth.autoLogin(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SplashScreen();
                      }
                      return const Login();
                    }),
            routes: {
              Item.routeName: (context) => const Item(),
              Login.routeName: (context) => const Login(),
              Register.routeName: (context) => const Register(),
              SplashScreen.routeName: (context) => const SplashScreen(),
            },
          );
        },
      ),
    );
  }
}
