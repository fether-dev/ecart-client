import 'dart:async';
import 'package:ecart_client1/categories_data.dart';
import 'package:ecart_client1/finalpayment.dart';
import 'package:flutter/material.dart';
import './main1.dart';
import './cart.dart';
void main() {
  runApp(new MaterialApp(
          debugShowCheckedModeBanner: false,

    home: new SplashScreen(),
   routes: <String, WidgetBuilder>{
        '/MyHomePage': (BuildContext context)=> new MyHomePage(),
          '/cart': (BuildContext context)=> new ItemList1(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds:5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/MyHomePage');
  }

  @override
  void initState() {
        this.startTime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
   /*   body: new Center(
 
          child:  new Image.asset('asset/cart.gif'),
 
      ),*/
         body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.redAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.greenAccent,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Welcome",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              new Image.asset('asset/cart.gif'),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  //  CircularProgressIndicator(),
                   new Image.asset('asset/load1.gif',height: 50.0,width: 50.0,),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Online Store",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}