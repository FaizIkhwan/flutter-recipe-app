import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/recipe_model.dart';

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
                child: Image.network(recipe.image),
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
                            if (formKey.currentState.validate()) _save();
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

  void _save() async {
    if (appBarTitle == "Add Recipe") {
      await _handleAddRecipe();
    } else if (appBarTitle == "Edit Recipe") {
      await _handleRecipeRecipe();
    }
    Navigator.pop(context, true);
  }

  Future<void> _handleAddRecipe() async {
    final recipeRef = FirebaseFirestore.instance.collection('recipe-list');
    await recipeRef.add(RecipeModel(
        title: titleController.text.toString(),
        instruction: instructionController.text.toString(),
        image: ""
    ).toJson());
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

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
