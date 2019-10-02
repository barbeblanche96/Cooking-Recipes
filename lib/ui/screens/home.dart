import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // New private method which includes the background image:
    BoxDecoration _buildBackground() {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/back.jpg"),
          fit: BoxFit.cover,
        ),
      );
    }

    Text _buildText() {
      return Text(
        'Travel the world through culinary art',
        style: TextStyle(fontFamily: 'Merriweather', fontStyle: FontStyle.italic, fontSize: 40.0, color: const Color(0xFF807A6B)),
        textAlign: TextAlign.center,
      );
    }


    return Scaffold(
      // We do not use backgroundColor property anymore.
      // New Container widget wraps our Center widget:
      body: Container(
        decoration: _buildBackground(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildText(),
              SizedBox(height: 50.0),
              MaterialButton(
                color: Colors.white,
                child: Text("Discover", style: TextStyle(fontFamily: 'Merriweather', fontStyle: FontStyle.italic, fontSize: 20.0, color: const Color(0xFF807A6B),)),
                onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}