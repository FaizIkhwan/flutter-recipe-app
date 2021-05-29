import 'package:flutter/material.dart';
import 'package:recipe_app/recipe_detail_screen.dart';
import 'package:recipe_app/recipe_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    CollectionReference recipeRef = FirebaseFirestore.instance.collection('recipe-list');
    await recipeRef
        .doc(recipe.id)
        .delete()
        .then((value) => print("success delete"))
        .catchError((error) => print("Failed to delete user: $error"));

    recipeList = List<RecipeModel>();
    updateListView();
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
      recipeList = List<RecipeModel>();
      updateListView();
    }
  }

  void updateListView() {
    print("updateListView");
    FirebaseFirestore.instance
        .collection('recipe-list')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (this.recipeList.where((element) => element.id == doc.id).isEmpty) {
          setState(() {
            this.recipeList.add(RecipeModel(
              id: doc.id,
              title: doc['title'],
              instruction: doc['instruction'],
              image: doc['image'],
            ));
            this.count = recipeList.length;
          });
        }
        print("recipeList: $recipeList");
      });
    });
  }
}
