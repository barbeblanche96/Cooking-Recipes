class Recipe {
  String id;
  String name;
  String origin;
  String duration;
  String img;
  String url;
  List<String> ingredients;
  List<String> methods;

  Recipe(String id, String name, String origin, String duration, String img, String
  url, List<String> ingredients, List<String> methods){

    this.id = id;
    this.name = name;
    this.origin = origin;
    this.duration = duration;
    this.img = img;
    this.url = url;
    this.ingredients = ingredients;
    this.methods = methods;
  }


  Recipe.fromJson(Map json)
      : id = json['id'].toString(),
        name = json['name'],
        origin = json['origin'],
        duration = json['duration'],
        img = json['img'],
        url = json['url'],
        ingredients = json['ingredients'].cast<String>(),
        methods = json['methods'].cast<String>();

  Map toJson() {
    return {'id': id, 'name': name, 'origin': origin, 'duration': duration, 'img': img, 'url': url, 'ingredients': ingredients, 'methods': methods};
  }
}
