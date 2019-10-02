import 'package:flutter/material.dart';

import 'package:best_of_cooking/models/Recipe.dart';

class RecipeTitle extends StatelessWidget {
  final Recipe recipe;
  final double padding;

  RecipeTitle(this.recipe, this.padding);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        // Default value for crossAxisAlignment is CrossAxisAlignment.center.
        // We want to align title and description of recipes left:
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            recipe.name,
            style: Theme.of(context).textTheme.title,
          ),
          // Empty space:
          SizedBox(height: 10.0),
          Row(
            children: [
              Icon(Icons.timer, size: 20.0),
              SizedBox(width: 5.0),
              Text(
                recipe.duration+" minutes",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text("Origin : "+recipe.origin, style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic ,color: const Color(0xFF807A6B),),),
          )
        ],
      ),
    );
  }
}
