# login_node_jwt

A new Flutter project.

## Getting Started

This is an app that has both login and register implementation.

It fetches its data from a local fake_node_jwt_server that has routes for login and register.

The login and register routes use jwt authentication. Other routes such as /products, /families, /locations, /transactions require the token in order to get data from it.

This app gets the token from the server response once the user logs in and passes it to the api that calls the other routes.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# Login-App-From-Node-JWT
