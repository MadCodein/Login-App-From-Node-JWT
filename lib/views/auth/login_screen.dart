import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants.dart';
import '/viewModel/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static const String routeName = loginRoute;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _isLoading = false;
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              enableSuggestions: false,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                labelText: 'Email',
              ),
              onChanged: (String value) {
                _email = value;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                labelText: 'Password',
              ),
              onChanged: (String value) {
                _password = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final provider = Provider.of<Auth>(context, listen: false);
                  await provider.signIn(_email, _password);

                  setState(() {
                    _isLoading = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Login Successful with userId: ${provider.userId}"),
                    ),
                  );

                  setState(() {
                    _isLoading = false;
                  });
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, homeRoute, (route) => false);
                } catch (error) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.toString()),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Login"),
            ),
            TextButton(
              onPressed: () async {
                await Navigator.pushNamedAndRemoveUntil(
                    context, registerRoute, (route) => false);
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
