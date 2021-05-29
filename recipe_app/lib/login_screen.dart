import 'package:flutter/material.dart';
import 'package:recipe_app/recipe_list_screen.dart';
import 'dart:async';
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
                      validator: (text) => text.isEmpty ? "Email cannot be empty" : null,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                    ),

                    TextFormField(
                      controller: passwordController,
                      obscureText: true, // password
                      validator: (text) => text.isEmpty ? "Password cannot be empty" : null,
                      decoration: InputDecoration(
                        labelText: "Password",
                      ),
                    ),

                    ElevatedButton(
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
                    ),

                    ElevatedButton(
                      child: Text("Register"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(String email, String password) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeListScreen()),
    );
  }
}
