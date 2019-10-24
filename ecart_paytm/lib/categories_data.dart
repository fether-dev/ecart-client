import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'orderproduct.dart';
class Categories_data extends StatefulWidget {   
  int index;
   
   List list;
      Categories_data({this.index,this.list});
   var p_img; 
@override
  _Categories_dataState createState() => new _Categories_dataState();
  //@override
   }
  class _Categories_dataState extends State<Categories_data> {
   var response;
     Future<List> listcategories() async {
    print('Inside listcategories');
    print("widget.list[widget.index]['category']"+widget.list[widget.index]['category']);
  var category=widget.list[widget.index]['category'];
         response =   await http.get('http://fluttertest.000webhostapp.com/listcategories.php?category=$category');

    // response =   await http.get('http://192.168.122.1/ecart/load_cart.php?username=$username');
       // print(response.statusCode);
    if (response.statusCode == 200) {
      print('response.body:' + response.body);
     // count=response.body.length;
    //print("count"+count.toString());
       await Future.delayed(Duration(seconds: 2));
     // print("response.body"+response.body);
      {
           return json.decode(response.body);
           ;
      }
      
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }  
  }
  @override
   void initState() {
     //this.listcategories();
    super.initState();
     }
       Widget build(BuildContext context) {
          List list;
        
      return Scaffold(
        appBar: AppBar(title: Text("Categories Details"),backgroundColor: Colors.red,),
        resizeToAvoidBottomPadding: false,
       
       body: new   Container(
           height:1000.0,
          child: new Center(
                 // height: 100.0,
          //width: 150.0,
              child:   Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                        // Padding(
        //  padding: const EdgeInsets.all(8.0),
           Expanded(
                  child: FutureBuilder<List>(
           
            future: listcategories(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
             ///  snapshot.data.child(product_name).getValue() != null;

              return snapshot.hasData
                  ? new ItemList(

                      list: snapshot.data,
                      //snapshot.data[0]['ototal']
                      
                     
                    )

                   
                  : new Center(
                      child: new CircularProgressIndicator(),
                    );
                    
            },
             
                
          
                  ),
   
               /*  if (snapshot.data.exists()) {
                  setState(() {
                        msg="Product Already in cart";
                      }); }
                      else{
                        setState(() {
                        msg1="Added Successfully";
                      }); 
                      }*/
                       
           ),

               
        /* new RaisedButton(
                  child: new Text("Sample", textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),),
                  color: Colors.lightBlue,
                      onPressed: (){
                    
                Navigator.of(context).push(
               
                    new MaterialPageRoute(
                        builder: (BuildContext context)=>new Cartupdate(
                        list :list,
                        //index:i,
                        ),
                       
            )
                  );
                  },)*/
                ],
                
          )

          )
      
        
             ),

      );
    }
  }
  
  
 class ItemList extends StatefulWidget {
      List list;
      int index; 
  

    ItemList({this.list,this.index});

  @override
  ItemListState createState() => ItemListState();
  //_ItemListState createState() => _ItemListState();

}
 
//class _ItemListState extends State<ItemList>  {
 class ItemListState extends State<ItemList>  {
 int cart_count;

  int index;
      String order_id;
String id;
 
    
     
  
  Widget build(BuildContext context) {
   // final items = List<String>.generate(widget.list.length, (i) => "Item $i");
    // new Container(
        return new   ListView.builder(
            //scrollDirection: Axis.vertical,
           //     shrinkWrap: true,
                  itemCount: widget.list == null ? 0 : widget.list.length,
          itemBuilder: (context, i) {
                   return new Container(  
                      //width: 550.0,
                    // height: 200.0,
                     // padding: const EdgeInsets.all(10.0),
              child:         new SingleChildScrollView(
                      child: new GestureDetector(
                        onTap: () {
                        //  print("hai"+i.toString());
                           Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new ProductDisp(
                                  list: widget.list,
                                  index: i,
                                )));
                                },
                      
                        child: new Card(
                             //   color: Colors.amber,
                          child: new ListTile(
                           // isThreeLine: true,
                           
                             title: 
                         
                            Text("${widget.list[i]['product_name']}",style: new TextStyle(fontSize: 15.0,color:Colors.blue,fontWeight: FontWeight.bold),),
                           
                       leading: 
                                        CircleAvatar(
                               // radius: 40.0,
                                //minRadius: 10.0,
                                maxRadius: 30.0,
                                backgroundImage:
                                  NetworkImage("http://fluttertest.000webhostapp.com/upload/${widget.list[i]['img_name']}"),
                                  //  NetworkImage("http://192.168.122.1/ecart/upload/${widget.list[i]['img_name']}"),
                                backgroundColor: Colors.transparent,
                              ),

                        
     
 
                ),
               
              ),
                      ),
            ),
          
          );  
         // );
        },
        
       
      );
  // );
    
    }

   
}
  
