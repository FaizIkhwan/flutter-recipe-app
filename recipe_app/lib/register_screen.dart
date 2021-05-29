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
                        validator: (String text) {
                          if(text.isEmpty)
                            return "Email cannot be empty";
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                      ), // end TextFormField Username

                      TextFormField(
                        controller: passwordController,
                        obscureText: true, // password
                        validator: (String text) {
                          if(text.isEmpty)
                            return "Password cannot be empty";
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                      ), // end TextFormField Password

                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true, // password
                        validator: (String text) {
                          if(text.isEmpty)
                            return "Password cannot be empty";
                        },
                        decoration: InputDecoration(
                          labelText: "Confirm password",
                        ),
                      ), // end TextFormField Confirm password

                      RaisedButton(
                        child: Text("Register"),
                        onPressed: registerButtonPressed,
                      ), // end RaisedButton
                    ],
                  ),
                ), // end form
              ],
            ), // end column
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
              FlatButton(
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
