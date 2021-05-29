import 'package:flutter/material.dart';
import 'package:recipe_app/recipe_detail_screen.dart';
import 'package:recipe_app/recipe_model.dart';

class RecipeListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecipeListScreenState();
  }
}

class RecipeListScreenState extends State<RecipeListScreen> {
  List<RecipeModel> recipeList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (recipeList == null) {
      recipeList = List<RecipeModel>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          RecipeModel recipe = RecipeModel(
            title: "",
            instruction: "",
            image: "",
          );
          navigateToRecipeDetail(recipe, "Add Recipe");
        },
        tooltip: "Add Recipe",
        child: Icon(Icons.add),
      ),
    );
  } // build method

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          //card layout
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(this.recipeList[position].title, style: titleStyle),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, recipeList[position]);
              },
            ),
            onTap: () {
              navigateToRecipeDetail(this.recipeList[position], "Edit Recipe");
            },
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, RecipeModel recipe) async {
    _showSnackBar(context, "Recipe Deleted Succesfully");
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToRecipeDetail(RecipeModel recipe, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RecipeDetailScreen(recipe, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    this.recipeList.add(RecipeModel(
      title: "Title 1",
      instruction: "Instruction 1",
      image: "https://i.stack.imgur.com/y9DpT.jpg",
    ));
    this.recipeList.add(RecipeModel(
      title: "Title 2",
      instruction: "Instruction 2",
      image: "Image 2",
    ));
    this.recipeList.add(RecipeModel(
      title: "Title 3",
      instruction: "Instruction 3",
      image: "Image 3",
    ));
    this.count = recipeList.length;
  }
}
