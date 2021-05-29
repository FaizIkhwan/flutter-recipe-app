import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/recipe_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String appBarTitle;
  final RecipeModel recipe;

  RecipeDetailScreen(this.recipe, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return RecipeDetailScreenState(this.recipe, this.appBarTitle);
  }
}

class RecipeDetailScreenState extends State<RecipeDetailScreen> {
  var formKey = GlobalKey<FormState>();
  String appBarTitle;
  RecipeModel recipe;
  TextEditingController titleController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  File _image;
  final picker = ImagePicker();

  RecipeDetailScreenState(this.recipe, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    titleController.text = recipe.title;
    instructionController.text = recipe.instruction;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: _image != null ? Image.file(_image) : Image.network(recipe.image),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextFormField(
                  controller: titleController,
                  style: textStyle,
                  validator: (text) => text.isEmpty ? "Please enter title" : null,
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextFormField(
                  controller: instructionController,
                  style: textStyle,
                  validator: (text) => text.isEmpty ? "Please enter description" : null,
                  decoration: InputDecoration(
                    labelText: "Instruction",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                child: Text(
                  "Add Image",
                  textScaleFactor: 1.5,
                ),
                onPressed: () {
                  _getImage();
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          "Save",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if (formKey.currentState.validate()) _save(titleController.text.toString(), instructionController.text.toString());
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          "Delete",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _delete();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToLastScreen() {
    Navigator.pop(context, true);
  }

  void _save(String title, String instruction) async {
    if (appBarTitle == "Add Recipe") {
      await _handleAddRecipe(title, instruction);
    } else if (appBarTitle == "Edit Recipe") {
      await _handleRecipeRecipe();
    }
    Navigator.pop(context, true);
  }

  Future<void> _handleAddRecipe(String title, String instruction) async {
    String url;
    if (_image != null) {
      url = await _handleUploadImage();
      print("url: $url");
    }
    final recipeRef = FirebaseFirestore.instance.collection('recipe-list');
    await recipeRef.add(RecipeModel(
      title: title,
      instruction: instruction,
      image: _image != null ? url : "",
    ).toJson());
    print("done add");
  }

  Future<String> _handleUploadImage() async {
    try {
      var uuid = Uuid();
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref('images/${uuid.v1()}.png');
      await ref.putFile(_image);
      return (await ref.getDownloadURL()).toString();
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> _handleRecipeRecipe() async {
    final recipeRef = FirebaseFirestore.instance.collection('recipe-list');
    await recipeRef
        .doc(recipe.id)
        .update({'title': titleController.text.toString(), 'instruction': instructionController.text.toString(), 'image': ""})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void _delete() async {
    CollectionReference recipeRef = FirebaseFirestore.instance.collection('recipe-list');
    await recipeRef
        .doc(recipe.id)
        .delete()
        .then((value) => print("success delete"))
        .catchError((error) => print("Failed to delete user: $error"));
    Navigator.pop(context, true);
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
