class RecipeModel {
  String title;
  String instruction;
  String image;

  RecipeModel({this.title, this.instruction, this.image});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    instruction = json['instruction'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['instruction'] = this.instruction;
    data['image'] = this.image;
    return data;
  }
}
