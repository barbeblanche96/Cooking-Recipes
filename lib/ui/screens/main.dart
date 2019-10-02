import 'package:flutter/material.dart';
import 'package:best_of_cooking/models/Recipe.dart';
import 'package:best_of_cooking/utils/store.dart';
import 'package:best_of_cooking/ui/widgets/recipe_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';


class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  // New member of the class:
  List<Recipe> recipes = [];
  List<String> userFavorites = [];

  _launchMail() async {
    const url = "mailto:erickitachi1996@example.com";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

   Future getRecipes() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/best_of_cooking.json");
    final jsonResult = json.decode(data);
    final recipesByCountry = jsonResult['best_of_cooking'];
    return recipesByCountry;
  }

  _getRecipes() async {
    getRecipes().then((response) {
      Iterable list_fr = response["french_recipes"]["list"];
      Iterable list_sa = response["south_africa_recipes"]["list"];
      Iterable list_ch = response["chinese_recipes"]["list"];
      Iterable list_us = response["usa_recipes"]["list"];
      Iterable list_au = response["australia_recipes"]["list"];
      setState(() {// get actuality list Json
      recipes.addAll(list_fr.map((model) => Recipe.fromJson(model))
          .toList());
      recipes.addAll(list_sa.map((model) => Recipe.fromJson(model))
          .toList());
      });
      recipes.addAll(list_ch.map((model) => Recipe.fromJson(model))
          .toList());
      recipes.addAll(list_us.map((model) => Recipe.fromJson(model))
          .toList());
      recipes.addAll(list_au.map((model) => Recipe.fromJson(model))
          .toList());
    });
  }


  _getFavoris() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> fav = prefs.getStringList('favoris');
    if (fav == null){
      fav = [];
    }
    setState(() {
      userFavorites = fav;
    });

  }


  _addFavoris(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> fav = prefs.getStringList('favoris');
    if (fav == null){
      fav = [];
    }
    fav.add(id);
    await prefs.setStringList('favoris', fav);
  }

  _deleteFavoris(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> fav = prefs.getStringList('favoris');
    if (fav == null){
      fav = [];
    }
    fav.remove(id);
    await prefs.setStringList('favoris', fav);
  }


  @override
  void initState() {
    super.initState();
    _getRecipes();
    _getFavoris();
  }

  // New method:
  // Inactive widgets are going to call this method to
  // signalize the parent widget HomeScreen to refresh the list view.
  void _handleFavoritesListChanged(String recipeID) {
    // Set new state and refresh the widget:
    setState(() {
      if (userFavorites.contains(recipeID)) {
        userFavorites.remove(recipeID);
        _deleteFavoris(recipeID);
      } else {
        userFavorites.add(recipeID);
        _addFavoris(recipeID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-7866611746481432~6394021370").then((response){
      myBanner..load()..show();
    });

    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-7866611746481432~6394021370").then((response){
      myBanner..load()..show();
    });
    // New method:
    Padding _buildRecipes(List<Recipe> recipesList) {
      return Padding( // New code
        // Padding before and after the list view:
        padding: const EdgeInsets.symmetric(vertical: 5.0), // New code
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: recipesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new RecipeCard(
                    recipe: recipesList[index],
                    inFavorites:
                    userFavorites.contains(recipesList[index].id),
                    onFavoriteButtonPressed: _handleFavoritesListChanged,
                  );
                },
              ),
            ),
          ],
        ),
      ); // New code
    }

    const double _iconSize = 20.0;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          // We set Size equal to passed height (50.0) and infinite width:
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 2.0,
            bottom: TabBar(
              labelColor: Theme.of(context).indicatorColor,
              tabs: [
                Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
                //Tab(icon: Icon(Icons.local_drink, size: _iconSize)),
                Tab(icon: Icon(Icons.favorite, size: _iconSize)),
                Tab(icon: Icon(Icons.info, size: _iconSize)),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: TabBarView(
            // Replace placeholders:
            children: [
              // Display recipes of type food:
              _buildRecipes(recipes
                  .toList()),
              // Display favorite recipes:
              _buildRecipes(recipes
                  .where((recipe) => userFavorites.contains(recipe.id))
                  .toList()),
              Container(
                child: ListView(
                  children: <Widget>[
                    Text("With this app we want to build a great collection of the world's best cooking recipes. New recipes will be added through our updates. We want to set up a reference application in the field of culinary arts. Support our project or get more information by contacting us through our email address : ", textAlign:TextAlign.justify, style: TextStyle(fontFamily: 'Merriweather', fontSize: 15.0, color: const Color(0xFF807A6B),)),
                    FlatButton(
                        textColor: const Color(0xFF807A6B),
                        child: new Text("erickitachi1996@gmail.com", style: TextStyle(decoration: TextDecoration.underline, fontFamily: 'Merriweather', fontStyle: FontStyle.italic, fontSize: 15.0, color: const Color(0xFF807A6B),)),
                        onPressed: () {
                          _launchMail();
                        }
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(child: Text("Cooking Recipes", style: TextStyle(fontSize: 25.0, fontStyle: FontStyle.italic ,color: const Color(0xFF807A6B),)),),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(child: Text("Version 1.1.3", style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic ,color: const Color(0xFF807A6B),)),),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(child: Image.asset(
                      'assets/favicon.png',
                      height: 129,
                      width: 129,
                      fit: BoxFit.fill,
                    ),),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(child: Text(" © 2019 BarbeBlanche App Inc", style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic ,color: const Color(0xFF807A6B),)),),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['Cooking', 'Cooking Recipes', 'Recipes', 'Meal', 'Food', 'Food Recipe'],
  contentUrl: 'https://flutter.io',
  childDirected: false,
 // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
  birthday: DateTime.now(),
  designedForFamilies: false,
  gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-7866611746481432/9061930209",
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);
