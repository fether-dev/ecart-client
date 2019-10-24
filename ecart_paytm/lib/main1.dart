import 'dart:async';
import 'dart:convert';
import 'package:ecart_client1/cart.dart';
import 'package:ecart_client1/home1.dart';
import 'package:ecart_client1/usercreation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'home1.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());
String username='';
/*Future<void> save_info() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp(home: email == null ? Login() : Home()));
}*/
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Login Page'),
            routes:  <String,WidgetBuilder>{
        '/Fpage': (BuildContext context)=> new Fpage(username: username,),

      '/cart': (BuildContext context)=> new Cart(),

        '/MyHomePage': (BuildContext context)=> new MyHomePage(),
      },
    );
  }
}
 

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, List list, int index}) : super(key: key);
  final String title;
      List list;
  int index;
 
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
   bool checkValue = false;

 

  SharedPreferences sharedPreferences;
  TextEditingController controlleruid = new TextEditingController();
   TextEditingController controllerpass = new TextEditingController();
   String msg='';
 _onChanged(bool value) async {
   print("inside   onChanged function");
   //print("object"+controlleruid.text);
   //print("object1"+controllerpass.text);
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", controlleruid.text);
      sharedPreferences.setString("password", controllerpass.text);
      sharedPreferences.commit();
      getCredential();
    });
  }
  getCredential() async {
       print("inside getCredential function");
   print("object"+controlleruid.text);
   print("object1"+controllerpass.text);
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          controlleruid.text = sharedPreferences.getString("username");
          controllerpass.text = sharedPreferences.getString("password");
        } else {
          controlleruid.clear();
          controllerpass.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }
  Future<List> _login() async {

   // void login(){
          final response = await http.post("http://fluttertest.000webhostapp.com/elogincheck.php", body: {

  //final response = await http.post("http://192.168.122.1/ecart/logincheck.php", body: {
    "username": controlleruid.text,
    "password": controllerpass.text,
 });
    // print("controlleruid.text.trimRight()"+controlleruid.text.trimRight());
//print(" controllerpass.text.trim()"+ controllerpass.text.trim(),);
 var datauser = json.decode(response.body);

  if(datauser.length==0){
    setState(() {
          msg="Incorrect Username or Password";
        });
  }else{
  
    setState(() {
         username= datauser[0]['username'];
         // Navigator.pushReplacementNamed(context, '/Fpage');
  Navigator.of(context).push(
               
                    new MaterialPageRoute(
                        builder: (BuildContext context)=>new Fpage(
                       
                        ),
                       
            )
                  );
        });

  }

  return datauser;
  
  } 
 // Text('No Internet Found');
 
  @override
   void initState() {
     this.getCredential();
     
     Timer.run(() {
      try {
        InternetAddress.lookup('google.com').then((result) {
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
          } else {
            _showDialog(); // show dialog
          }
        }).catchError((error) {
          _showDialog(); // show dialog
        });
      } on SocketException catch (_) {
        _showDialog();
        print('not connected'); // show dialog
      }
    });
    super.initState();
     
  
  }
   void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("No Internet Found!"),
            content: Text("Switch on Mobile Data or Wi-Fi!"),
            actions: <Widget>[FlatButton(child: Text("Ok"), onPressed: () {
              Navigator.pushReplacementNamed(context, '/MyHomePage');
            })],
          ),
    );
  }
    void dispose() {
 
    super.dispose();
  }


 
  Widget build(BuildContext context) {
 
    return Scaffold(
   
 
      body:SingleChildScrollView (
        child:Container(
    
        child: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[  
           
                 SizedBox(height: 90.0),
                 Image.asset("asset/logo.jpg",height: 70.0,width: 150,),
                SizedBox(height: 16.0),
                 new Text(
                  "E_CART",style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.brown)
 
                  
                ),
                  SizedBox(height: 50.0),
             new TextField(
                controller: controlleruid,
                  decoration: new InputDecoration(
                    icon: const Icon(Icons.person),
                    labelText: "UserName",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                new TextField(
                  controller: controllerpass,
                   obscureText: true, 
                  decoration: new InputDecoration(
                   icon: const Icon(Icons.lock),
                  labelText: "Password",
                    fillColor: Colors.white,
              
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                  

                  ),
              

                ),
                        CheckboxListTile(
            value: checkValue,
            onChanged: _onChanged,
            title: new Text("Remember me"),
            controlAffinity: ListTileControlAffinity.leading,
                        ), 
                SizedBox(
                  height: 10.0,
                ), 
                  Text(msg,style: TextStyle(fontSize: 15.0,color: Colors.red),),
                    
                   ButtonBar(
                     
              children: <Widget>[
               
                FlatButton(
                  child: Text('CANCEL'),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),   splashColor: Colors.black,
                  onPressed: () {
                  controlleruid.clear();
                  controllerpass.clear();
                  },
                ),
                RaisedButton(
                  child: Text('Login'),
                  elevation: 8.0,
                    splashColor: Colors.black,
                 onPressed:(){
                  _login();
                  
                 },
                  color: Colors.blueAccent,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                                  ),  
                 RaisedButton(
                  child: Text('Newuser'),
                  elevation: 8.0,   splashColor: Colors.black,
                  onPressed: () {
                    //editData();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new Ucreate()));
                  },
                  color: Colors.redAccent,
                   
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  
                  
                ),
                  
              
                       
              ],
            ),
         //  ),
          ],
        ),
        )
      ),
     
    );
  }
}
