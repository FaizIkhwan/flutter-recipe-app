import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:recipe_app/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
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
                      controller: emailController,
                      validator: (String text) {
                        if (text.isEmpty) return "Email cannot be empty";
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
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
                          String email = emailController.text;
                          String password = passwordController.text;

                          print("email: $email");
                          print("password: $password");

                          login(email, password);
                        }
                      },
                    ), // end RaisedButton

                    RaisedButton(
                      child: Text("Register"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
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

  Future<void> login(String email, String password) async {

  }
}
