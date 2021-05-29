import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
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
    Navigator.pop(context, true); // pass true kat navigator notelist
  }

  void _save() async {
    Navigator.pop(context, true);
  }

  void _delete() async {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog =
        AlertDialog(title: Text(title), content: Text(message));

    showDialog(context: context, builder: (_) => alertDialog);
  }
}