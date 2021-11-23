# login_node_jwt

An authentication Flutter project.

## Getting Started

This is an app that has both login and register implementation.

It fetches its data from a local fake_node_jwt_server that has routes for login and register.

The login and register routes use jwt authentication. Other routes such as /products, /families, /locations, /transactions require the token in order to get data from it.

This app gets the token from the server response once the user logs in and passes it to the api that calls the other routes.

# Login-App-From-Node-JWT
