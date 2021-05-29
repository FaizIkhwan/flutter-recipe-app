import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Recipe App",
      debugShowCheckedModeBanner: false,
      home: Text("hello world"),
    );
  }
}
