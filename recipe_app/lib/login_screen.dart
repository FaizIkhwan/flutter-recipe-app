import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: usernameController,
                      validator: (String text) {
                        if (text.isEmpty) return "Username cannot be empty";
                      },
                      decoration: InputDecoration(
                        labelText: "Username",
                      ),
                    ), // end TextFormField Username

                    TextFormField(
                      controller: passwordController,
                      obscureText: true, // password
                      validator: (String text) {
                        if (text.isEmpty) return "Password cannot be empty";
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                    ), // end TextFormField Password

                    RaisedButton(
                      child: Text("Login"),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          String username = usernameController.text;
                          String password = passwordController.text;

                          print("username: $username");
                          print("password: $password");

                          login(username, password);
                        }
                      },
                    ), // end RaisedButton

                    RaisedButton(
                      child: Text("Register"),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Register()),
                        // );
                      },
                    ), // end RaisedButton
                  ],
                ),
              ), // end form
            ],
          ), // end column
        ),
      ),
    );
  }

  Future<void> login(String username, String password) async {

  }
}
