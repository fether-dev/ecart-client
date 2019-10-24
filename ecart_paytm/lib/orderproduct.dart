import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cart.dart';
import 'home1.dart';
import 'main1.dart';

class ProductDisp extends StatefulWidget {
    //static final String route = "Home-route";
    List list;
  int index;
 // File  detail;
  //Details({this.detail});
  ProductDisp({this.index, this.list});
 
@override
  _ProductDispState createState() => new _ProductDispState();
}
class _ProductDispState extends State<ProductDisp> {



  @override
//String duplicate;
  String msg='';
    Future<String> msg1;
      String product_image,p_img;
  
 Future<String> insert_cart() async {
           
print("inside insert_cart");
  //var url="http://192.168.122.1/ecart/insert_cart.php";
      //var url="http://fluttertest.000webhostapp.com/eusercreation.php";
     final response = await http.post("http://fluttertest.000webhostapp.com/einsert_cart.php", body: {

   //  final response = await http.post("http://192.168.122.1/ecart/insert_cart.php", body: {
      "id" : widget.list[widget.index]['id'],
       "product_name" : widget.list[widget.index]['product_name'],
       "product_price" : widget.list[widget.index]['product_price'],
        "username"  : username,
        "img_name" :  widget.list[widget.index]['img_name'],

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
            Navigator.of(context).push(
               
                    new MaterialPageRoute(
                        builder: (BuildContext context)=>new Cart(
                       
                        ),
                       
            )
                  );
        });

  }
  return response.body;

   }
     void initState() {

       product_image = widget.list[widget.index]['img_name'];
         p_img = 'http://fluttertest.000webhostapp.com/upload/$product_image';
      // p_img = 'http://192.168.122.1/ecart/upload/$product_image';
       /* if (widget.list[widget.index]['product_name'].exists()) {
                  setState(() {
                        msg="Product Already in cart";
                      }); }
                      else{
                        setState(() {
                        msg1="Added Successfully";
                      }); 
                      }*/
                       /*  if (snapshot.data.exists()) {
                  setState(() {
                        msg="Product Already in cart";
                      }); }
                      else{
                        setState(() {
                        msg1="Added Successfully";
                      }); 
                      }
                        */
    super.initState();
       void dispose() {
 
    super.dispose();
  }

  }//String msg;
         /*   String msg='';
  Future<List> _login() async {


   // void login(){
          final response = await http.post("http://fluttertest.000webhostapp.com/elogincheck.php", body: {

  //final response = await http.post("http://192.168.122.1/ecart/logincheck.php", body: {
    "username": controlleruid.text,
    "password": controllerpass.text,
 });
     print("controlleruid.text.trimRight()"+controlleruid.text.trimRight());
print(" controllerpass.text.trim()"+ controllerpass.text.trim(),);
 var datauser = json.decode(response.body);

  if(datauser.length==0){
    setState(() {
          msg="Incorrect Username or Password";
        });
  }else{
  
    setState(() {
         username= datauser[0]['username'];
          //NavigatorKey.currentState.pushNamedAndRemoveUntil(context.Fpage, (dispProduct) => false);
          //Navigator.pushNamedAndRemoveUntil(Fpage.dispProduct()=>false);
//navigatorKey.currentState.pushNamedAndRemoveUntil(action.name, (_) => false);


          Navigator.pushReplacementNamed(context, '/Fpage');
        });

  }

  return datauser;
  
  }  */
         
    
  Widget build(BuildContext context) {
     MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
     );
   //  Size screenSize = MediaQuery.of(context).size;
    
     return new Scaffold(
           
        bottomNavigationBar: new BottomAppBar(
       // color: Theme.of(context).primaryColor,
                  //    backgroundColor: Colors.red,
                  //type: BottomNavigationBarType.shifting,
        color: Colors.white,
        elevation: 0.0,
        shape: new CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: new Container(
          height: 50.0,
          //decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                
              new Container(
                  //width: (screenSize.width - 20) / 2,
                child:ButtonTheme(
                   minWidth: 150.0,
                  height: 150.0,
                
                child:new RaisedButton(
               
                  child: new Text("Back", textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),),
                  color: Colors.lightBlue,
                      onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context)=>new Fpage()
                        )
                      ),
                ),
                ),
              ),
                //new Container(                 
              //),
              new Container(
              //  width: (screenSize.width - 30) / 2,
                child:ButtonTheme(
                   minWidth: 150.0,
                  height: 150.0,
                //)
                child:new RaisedButton(
                  
               
                  child: new Text("Add to Cart", textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),),
                  color: Colors.lightBlue,
                                        
                      onPressed: (){
                        //insert_cart();
                   
                     insert_cart();
                     
                     // Text(msg1);
               /* Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context)=>new Cart(),
            )
                );*/
                      },
                ),
              
                ),
              
              ),
                   //Text(msg,style: TextStyle(fontSize: 15.0,color: Colors.red),),
     // Text(msg,textAlign: TextAlign.justify,  style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

            ],
          ),
        ),
      ),
      //appBar: new AppBar(title: new Text("${widget.list[widget.index]['product_name']}")),
            appBar: new AppBar(title: new Text("Add to Cart"),backgroundColor: Colors.red,),

      body: new Container(
        //color: Colors.amber,
      //padding: const EdgeInsets.all(10.0),
        child: new Card(
          child: new Center(
            child: new SingleChildScrollView(
                      child: new Column(

                 mainAxisAlignment: MainAxisAlignment.center,

                 mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                
 
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                 Row(children:[
    Expanded(
          flex: 7, // 20%
          child:            Text('    Name ',textAlign: TextAlign.justify,  style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
        Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['product_name']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), ]
        ),
           Row(children:[
    Expanded(
          flex: 7, // 20%
          child:            Text('    Price ',textAlign: TextAlign.justify,  style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
        Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['product_price']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), ]
        ),
                 Row(children:[
    Expanded(
          flex: 7, // 20%
          child:            Text('    Category ',textAlign: TextAlign.justify,  style: new TextStyle( fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ),
        Expanded(
          flex: 1, // 20%
          child:       Text("  :",style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,),),

        ),
         Expanded(
          flex: 10, // 20%
          child:         Text("${widget.list[widget.index]['category']} ",  overflow: TextOverflow.fade, softWrap: false,  style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.blue,decorationColor: Colors.black,),),

        ), ]
        ),

            
                

             SizedBox(
               height: 10.0,
               width: 10.0,
             ),
            // new Padding(padding: const EdgeInsets.only(top: 10.0),),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    
                     CircleAvatar(
                      radius: 90.0,
                      backgroundImage:
                          NetworkImage(p_img),
                      backgroundColor: Colors.transparent,
                   ),
                     
    //Text(msg1,style: TextStyle(fontSize: 15.0,color: Colors.red),),

                  ],
                ),

             SizedBox(
               height: 10.0,
               width: 10.0,
             ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Text(msg,style: TextStyle(fontSize: 25.0,color: Colors.red),),
                   /*   InkResponse(
                        
                        onTap: (){
                        Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(msg),
                     ));
                        },
                      )*/
                  ],
                )
                 
              ],
              
            ),
            
            ),
        
           
          ),
        ),
        
      ),
      
    );
  }
}