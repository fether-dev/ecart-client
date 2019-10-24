
import 'dart:async';
import 'dart:convert'; 
import 'package:ecart_client1/cart.dart';
import 'package:ecart_client1/categories.dart';
import 'package:ecart_client1/finalpayment.dart';
import 'package:ecart_client1/main1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'main1.dart';

class SizeConfig {
 static MediaQueryData _mediaQueryData;
 static double screenWidth;
 static double screenHeight;
 static double blockSizeHorizontal;
 static double blockSizeVertical;
  void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  blockSizeHorizontal = screenWidth / 100;
  blockSizeVertical = screenHeight / 100;
 }
}

  /*void main() {
    runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Fpage(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.isInitialRoute) {
          return Fpage.route();
        }
        return null;
      },
    ));
  }*/
  class Fpage extends StatefulWidget {
  final List list;
  String username;
    final int index;
      Fpage({this.username,this.list,this.index});
 static Route<dynamic> route() {
    return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 6),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Fpage();
      },
    );
  }
  @override
  _FpageState createState() => new _FpageState();
  

  }

 
NotificationDetails get _ongoing {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.None,
    priority: Priority.High,
    ongoing: false,
    autoCancel: false,
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}
  
  class _FpageState extends  State<Fpage> {
  
      List data=[];
      Future<String> dispProduct() async {
        print('Inside dispProduct');
    //     print("width" + MediaQuery.of(context).size.width.toString());
        await Future.delayed(Duration(seconds: 0));
        final response =
        //fluttertest.000webhostapp.com
          await http.get( "http://fluttertest.000webhostapp.com/edisp_pimg.php",
        //   await http.get( "http://192.168.122.1/ecart/disp_pimg.php",
            //"user_name" : username
            );
        
          this.setState(() {
        data = json.decode(response.body);
      });
      //print(data[1]["img_name"]);
          return "Success!";  
      }  

      String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }
     final notifications = FlutterLocalNotificationsPlugin();

   Future<void> _showDailyAtTimes() async {
   print("inside _showDailyAtTime");

   var scheduledNotificationDateTime =
        new DateTime.now().add(new Duration(seconds: 5));
  var androidPlatformChannelSpecifics =
     new AndroidNotificationDetails('your other channel id',
    'your other channel name', 'your other channel description');
  var iOSPlatformChannelSpecifics =
   new IOSNotificationDetails();
   NotificationDetails platformChannelSpecifics = new 
  NotificationDetails(androidPlatformChannelSpecifics,iOSPlatformChannelSpecifics);
  await notifications.schedule(0,'scheduled title', 'scheduled body',scheduledNotificationDateTime,platformChannelSpecifics); 
   }
 Future<void> _showDailyAtTime() async {
   print("inside _showDailyAtTime");
    var time = Time(16, 25, 0);
     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await notifications.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpecifics);

       // notifications.show();
         //   print("time"+time.hour.toString());
          //  print("time"+_toTwoDigitString(time.hour).toString());
          //  print("time"+time.second.toString());
 }


Future _showNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  int id = 0,
}) =>
    notifications.show(id, title, body, type);
Future showOngoingNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  int id = 0,
}) =>
    _showNotification(notifications,
        title: title, body: body, id: id,type: _ongoing );




  showNotification() async {
    print("haiiiiiiiiiiiiiiiii");
    var android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    var scheduledNotificationDateTime =
        new DateTime.now().add(Duration(minutes: 1));
    await notifications.schedule(0, 'schedulenotification ', 'Body', scheduledNotificationDateTime, platform);
  }
   
   @override
     startTime() async {
    var _duration = new Duration(seconds:5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
  Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Fpage(
                           )));  }

    void initState() {   
      print("date"+TimeOfDay.now().toString());
      this.dispProduct();
       
      super.initState();
    
    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
       InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
//{notification: {body: abc, title: abc}, data: {url: string, body: string, title: string}}

     this.showOngoingNotification(notifications,title: 'hai $username', body: 'welcome to Freshgoods');
      this. _showDailyAtTime();
        
             
      // this.showNotification();          

  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Cart()),
  );
    String msg='';
    Future<String> msg1;
 var crossAxisCount;
 var width;
    Widget build(BuildContext context) {
    /*SizeConfig().init(context);
     double defaultScreenWidth = 400.0;
  double defaultScreenHeight = 810.0;
  ScreenUtil.instance = ScreenUtil(
    width: defaultScreenWidth,
    height: defaultScreenHeight,
    allowFontScaling: true,
  )..init(context);*/
   print("width" + MediaQuery.of(context).size.width.toString());

  width = MediaQuery.of(context).size.width;
    if (width<=500.0) {
             crossAxisCount = 2;

      } 
     /*  else if(width <= 600.9389348488247){
             crossAxisCount =2;
       }*/

      else if(width<=650.0) {
        crossAxisCount = 3;                  
              }
                else if(width<=900.0) {
        crossAxisCount = 3;                  
              }
               else  {
        crossAxisCount = 4;                  
              }
              return Scaffold(
                  appBar: new AppBar(
                    elevation: 0.1,
                backgroundColor: Colors.red,
                title: Text('FreshGoods'),
                actions: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: InkResponse(
                      
                          child: Icon(Icons.add_shopping_cart),
                            //color: Colors.black,
                            onTap:(){
                                  //load_cart();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Cart(
                            //  list: data1,
                            // index: index1,
                          )));
                
                            },/*        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                                        builder: (BuildContext context) => new ProductDisp(
                                              list: data,
                                              index: index,
                                            ))), */
                                      
                                    ),
                                  ),
                                
                                ],
                              )
                            ],
                          
                            
                          ),
                          drawer: new Drawer(
                            child: new ListView(
                              children: <Widget>[
                    //            header
                                new UserAccountsDrawerHeader(
                                    accountName: Text('Admin'),
                                    accountEmail: Text('Admin@gmail.com'),
                                    //  accountEmail: Text("hai:+${username}"),
                                currentAccountPicture: GestureDetector(
                                  child: new CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: Icon(Icons.person, color: Colors.white,),
                                  ),
                                ),
                                decoration: new BoxDecoration(
                                  color: Colors.red
                                ),
                                ),
                    
                              InkWell(
                                onTap: (){
                                    Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Fpage(
                            //  list: data1,
                            // index: index1,
                          )));

                                },
                                
                                child: ListTile(
                                  title: Text('Home Page'),
                                  leading: Icon(Icons.home),
                                ),
                              ),
                    
                                InkWell(
                                  onTap: (){},
                                  child: ListTile(
                                    title: Text('My account'),
                                    leading: Icon(Icons.person),
                                  ),
                                ),
                    
                                InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Cartupdate(
                            //  list: data1,
                            // index: index1,
                          )));
                                  },
                                  child: ListTile(
                                    title: Text('My Orders'),
                                    leading: Icon(Icons.shopping_basket),
                                  ),
                                ),
                    
                                InkWell(
                                
                                            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                                        builder: (BuildContext context) => new  Categories(
                                              //list: data,
                                            // index: index,
                                            ))),
                                  child: ListTile(
                                    title: Text('Categories'),
                                    leading: Icon(Icons.dashboard),
                                  ),
                                ),
                    
                                InkWell(
                                  onTap: (){
                                  Navigator.pushReplacementNamed(context,'/MyHomePage');

                                  },
                
                                  child: ListTile(
                                    title: Text('Logout'),
                                    leading: Icon(Icons.lock_open),
                                  ),
                                ),
                    
                                Divider(),
                    
                                InkWell(
                                  onTap: (){},
                                  child: ListTile(
                                    title: Text('Settings'),
                                    leading: Icon(Icons.settings, color: Colors.blue,),
                                  ),
                                ),
                    
                                InkWell(
                                  onTap: (){},
                                  child: ListTile(
                                    title: Text('About'),
                                    leading: Icon(Icons.help, color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                            ),
                    
                            resizeToAvoidBottomPadding: false ,
                         body: 
                                  new GridView.builder(
                                      shrinkWrap: true,       
                                       primary: false,
  padding: const EdgeInsets.all(10.0),
   
                                      scrollDirection: Axis.vertical,
                                    itemCount: data.length,
                                  
                                      gridDelegate:
                                          new SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: crossAxisCount,
                                                   childAspectRatio: (10/10),
                                          ),
                                      itemBuilder: (BuildContext context, int index) {
                                        return new GestureDetector(
                                          child: new Container(
                                            //  margin: EdgeInsets.only(top: ScreenUtil.instance.setWidth(10.0)),
  //padding: EdgeInsets.all(ScreenUtil.instance.setWidth(1.0)),
                                            
                                            // height: SizeConfig.blockSizeVertical * 20,
                                        //     width: SizeConfig.blockSizeHorizontal * 50,
                                  /// width: MediaQuery.of(context).size.width - 100.0,
                                        decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(0.0),
                                             //    shape: BoxShape.circle,
                                            ),
                                            
                                            child: new Card(
                  color: Colors.white,
                           // margin: const EdgeInsets.only(top: 20.0),
                              child: Padding(
                              padding: const EdgeInsets.all(5.0),
                                               
                                        //    elevation: 12.0,

                                          
                                              child: new Container(
                                            //    height: SizeConfig.blockSizeVertical * 120,
                                             //   width: SizeConfig.blockSizeHorizontal * 150,
                                               // width: 1000.0,
                                               // height: 2000.0,
                                  child: SingleChildScrollView(
                                                                                 
                                                  child: new Column(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  
                                                    children: <Widget>[  
                                                 //     Wrap(),                                            
                           Image.network('http://fluttertest.000webhostapp.com/upload/${data[index]["img_name"]}',
                           width: 100, height: 90,
                     //     height: ScreenUtil.instance.setHeight(180.0),
   // width: ScreenUtil.instance.setHeight(180.0),
  // width:  MediaQuery.of(context).size.width,
  //height : MediaQuery.of(context).size.height,                                                    
  //fit: BoxFit.cover,

  ),
      // Text("${data[index]['product_name']} - ${data[index]['product_price']}",  
        //                                    style:new TextStyle(fontSize: 15.0,color:Colors.redAccent, fontWeight: FontWeight.bold,),), 

                                 //SizedBox(width: 20.0,height: 15.0),                              
                                                              
                                                    new Container(
                                                      
                                                    
                                                   child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                 // child:  Wrap(
                                                    children: <Widget>[
                                                     //   Wrap(),
                                                   
                                          Text("${data[index]['product_name']} - Rs ${data[index]['product_price']}",  style:new TextStyle(fontSize: 10.0,color:Colors.redAccent, fontWeight: FontWeight.bold,),), 
                                                      //  Text(msg,style: TextStyle(fontSize: 25.0,color: Colors.red),),
                                                       new RaisedButton(
                  
               
                  child: new Text("Add to Cart", textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),),
                  color: Colors.lightBlue,
                                        
                      onPressed: (){
                          Future<String> insert_cart() async {
           
              print("inside insert_cart");
                 
                  final response = await http.post("http://fluttertest.000webhostapp.com/einsert_cart.php", body: {
                    
                   // "id" : widget.list[widget.index]['id'],
                   "id": data[index]['id'],
                    "product_name" :  data[index]['product_name'],
                    "product_price" : data[index]['product_price'],
                    "username"  : username,
                     "img_name" :   data[index]['img_name'],

                  });

              //var datauser = json.decode(response.body).toString();
              print('response.body'+ response.body);
              //String datauser = response.body;
              //int res=0;
              //print("res"+res);
              // print("datauser"+datauser);
              //  print("res"+res.toString());
              // if(datauser.toString()==res.toString()){
                if(response.body =="\nduplicate\n"){
                  print('hello');
                    setState(() {
                        msg="Already in cart";
                      // Navigator.pushReplacementNamed(context, '/cart');
                      });
                }
                else{
                  print('hai');
                  setState(() {
                      msg="Added";
                        //msg="Product already in cart";
                        //    Navigator.pushReplacementNamed(context, '/cart');
                       
                      });

                }
                return response.body;

   }
                               insert_cart();
                
                      },
                                                       ),
 
                               
                   /*      InkResponse(
                      
                          child: 
                           Icon(Icons.add_shopping_cart),
                            //color: Colors.black,
                            onTap:(){
                 Future<String> insert_cart() async {
           
              print("inside insert_cart");
                 
                  final response = await http.post("http://fluttertest.000webhostapp.com/einsert_cart.php", body: {
                    
                   // "id" : widget.list[widget.index]['id'],
                   "id": data[index]['id'],
                    "product_name" :  data[index]['product_name'],
                    "product_price" : data[index]['product_price'],
                    "username"  : username,
                     "img_name" :   data[index]['img_name'],

                  });

              //var datauser = json.decode(response.body).toString();
              print('response.body'+ response.body);
              //String datauser = response.body;
              //int res=0;
              //print("res"+res);
              // print("datauser"+datauser);
              //  print("res"+res.toString());
              // if(datauser.toString()==res.toString()){
                if(response.body =="\nduplicate\n"){
                  print('hello');
                    setState(() {
                        msg="Already in cart";
                      // Navigator.pushReplacementNamed(context, '/cart');
                      });
                }
                else{
                  print('hai');
                  setState(() {
                      msg="Added";
                        //msg="Product already in cart";
                        //    Navigator.pushReplacementNamed(context, '/cart');
                       
                      });

                }
                return response.body;

   }
                               insert_cart();
                
                            },
                                      
                          ),*/
                                                    
                                                     
                                                    ],//),
                                                    ),// )
                                                    // Theme.of(context).textTheme.headline)
                                                  ),

                                                  
                                                      /* new Container(
                                                    child: Text("${data[index]['product_price']}",  
                                            style:new TextStyle(fontSize: 10.0,color:Colors.redAccent, fontWeight: FontWeight.bold,),), 
                                          // Theme.of(context).textTheme.headline)
                                                  ),*/
                                                //  new Container(
                                                   // child:Row(
                                                     // children: <Widget>[
              
                                                    //  ],
                                                   // ) 
                                                    
               
                                           //       )
                                                     
                                                  ],) 
                                              ),
                             
                                              ),
                                            ),
                                                
                                            )
                                            
                                            
                                          ),
                                          
                                            /*onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                                        builder: (BuildContext context) => new ProductDisp(
                                              list: data,
                                              index: index,
                                            ))),*/
                                            );
                                      },
                                  ),
                                    
                                  
                          );
              
                                }
                    }
                    
