import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants.dart';
import '/viewModel/auth_provider.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  static const String routeName = registerRoute;

  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";
    final GlobalKey<FormState> _formKey = GlobalKey();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Register",
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "All fields are required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  labelText: 'Confirm Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "All fields are required";
                  }
                  if (value != _password) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    await Provider.of<Auth>(context, listen: false)
                        .signUp(_email, _password);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Account created successfully"),
                      ),
                    );
                    Navigator.of(context).pushReplacementNamed(loginRoute);
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
                child: const Text("Register"),
              ),
              TextButton(
                onPressed: () async {
                  await Navigator.pushNamedAndRemoveUntil(
                      context, loginRoute, (route) => false);
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
