import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
            child: Column(
              children: <Widget>[

                Container(
                  margin: EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: Text(
                    "Register",
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

                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true, // password
                        validator: (text) => text.isEmpty ? "Password cannot be empty" : null,
                        decoration: InputDecoration(
                          labelText: "Confirm password",
                        ),
                      ),

                      ElevatedButton(
                        child: Text("Register"),
                        onPressed: registerButtonPressed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerButtonPressed() {
    if(formKey.currentState.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      String confirmPassword = confirmPasswordController.text;

      if(password == confirmPassword) {
        register(email, password);
      } else {
        _showDialog("Password does not match");
      }
    }
  }

  Future<void> register(String email, String password) async {
    print("username: $email");
    print("password: $password");

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showDialog('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    _showDialog("Success register");
  }

  void _showDialog(String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
}
