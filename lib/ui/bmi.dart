import 'dart:math';

import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BMIState();
}

class BMIState extends State<BMI> {

  String _bmiCountText = "";
  String _bmiStatus = "";

  TextEditingController _ageController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();

  caluclate() {
    setState(() {
      if (_ageController.text.isNotEmpty && _heightController.text.isNotEmpty && _weightController.text.isNotEmpty) {
        int height = 0;
        if(_heightController.text.contains(".")) {
          var index = _heightController.text.split(".");

          height = int.parse(index[0])*12 + int.parse(index[1]);
          print("Your height is $height");
        } else {
          height = int.parse(_heightController.text)*12;
        }
        double _bmi = (double.parse(_weightController.text)*2.20462/(height*height))*703;
        _bmiCountText = "Your BMI is ${_bmi.toStringAsFixed(2)}";

        if(_bmi < 18.5) {
          _bmiStatus = "underweight".toUpperCase();
        } else if(_bmi >= 18.5 && _bmi <= 24.9){
          _bmiStatus = "ideal".toUpperCase();
        } else if(_bmi >= 25 && _bmi <= 29.9){
          _bmiStatus = "overweight".toUpperCase();
        } else if(_bmi >= 30){
          _bmiStatus = "obesity".toUpperCase();
        }
      }
    });
  }

  erase() {
    setState(() {
      _ageController.clear();
      _heightController.clear();
      _weightController.clear();
      _bmiCountText = "";
      _bmiStatus = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("BMI"),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent,
        ),
        backgroundColor: Colors.white,
        body: new Container(
          margin: EdgeInsets.all(16),
          child: new ListView(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(16),
                child: new Image.asset("images/bmilogo.png", height: 100,width: 100,),
              ),
              new Card(
                elevation: 4,
                color: Colors.white,
                child: new Padding(
                  padding: EdgeInsets.all(16),
                  child: new Column(
                    children: <Widget>[
                      new TextField(
                          controller: _ageController,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: false),
                          decoration: new InputDecoration(
                              icon: new Icon(Icons.person), hintText: "Age")),
                      new TextField(
                          controller: _heightController,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          decoration: new InputDecoration(
                              icon: new Icon(Icons.assessment),
                              hintText: "Height")),
                      new TextField(
                          controller: _weightController,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: false),
                          decoration: new InputDecoration(
                              icon: new Icon(Icons.line_weight),
                              hintText: "Weight")),
                      new Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new RaisedButton(
                              onPressed: caluclate,
                              child: Text(
                                "Calculate",
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              color: Colors.purpleAccent,
                            ),
                            new RaisedButton(
                              onPressed: erase,
                              child: Text(
                                "Clear",
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              color: Colors.purpleAccent,
                            )
                          ],
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: new Text(
                          "$_bmiCountText",
                          style: new TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: new Text(
                          "$_bmiStatus",
                          style: new TextStyle(
                              color: Colors.redAccent.shade400,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
