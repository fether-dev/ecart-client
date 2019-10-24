import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'categories_data.dart';
import 'main1.dart';
class Categories extends StatefulWidget {   
  int index;
  final String username;
   List list;
      Categories({this.index,this.list,this.username});
   var p_img; 
@override
  _CategoriesState createState() => new _CategoriesState();
}
     class _CategoriesState extends  State<Categories>{
  @override
     var response;

       Future<List> load_category() async {
    print('Inside load_category');
    //await Future.delayed(Duration(seconds: 2));
     username = username;
    //  print('FLUTTERUSERNAME'+username);  
    //fluttertest.000webhostapp.com
       response =   await http.get('http://fluttertest.000webhostapp.com/categories.php');
    //response =   await http.get('http://192.168.122.1/ooowb/categories.php');
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
           
      }
      
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }  
  }
 Widget build(BuildContext context) {
          List list;
        
      return Scaffold(
        appBar: AppBar(title: Text("Categories"),backgroundColor: Colors.red,),
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
           
            future: load_category(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
             ///  snapshot.data.child(product_name).getValue() != null;

              return snapshot.hasData
                  ? new ItemList(

                      list: snapshot.data,  
                      //snapshot.data[0]['ototal']
                      
                     
                    )

                  /*new ItemList(
                      list: snapshot.data,
                     // index: i,
                     // order_id: snapshot.data,
                  )*/
                  : new Center(
                      child: new CircularProgressIndicator(),
                    );
                    
            },
             
                
          
          ),
   
                       
           ),

               
        /* new RaisedButton(
                  child: new Text("Make Payment", textAlign: TextAlign.center,
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

      /*      new GridView.builder(
                                      shrinkWrap: true,                
                                      scrollDirection: Axis.vertical,
                                    itemCount: data.length,
                                      gridDelegate:
                                          new SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemBuilder: (BuildContext context, int index) {
                                        return new GestureDetector(
                                          child: new Container(
                                                    // width: MediaQuery.of(context).size.width - 100.0,
                                        decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                // shape: BoxShape.circle,
                                            ),
                                            
                                            child: new Card(
                                                  color: Colors.white,
                                      //     semanticContainer: true ,
                                          //  borderOnForeground: true,
                                          //ShapeBorder: BoxBorder.circle,
                                          //   elevation: 5.0,
                                      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),

                                        //      new Column(
                                          //      children: <Widget>[
  ///
                                          ///],
                                          //     )

                                          
                                              child: new Container(
                                                    
                                              /// padding: new EdgeInsets.only(
                                                  //  bottom: 2.0, right: 3.0,top: 5.0),
                                                    
                                        //   child: Text("Name : ${data[index]['product_name']}",  
                                          // style: new TextStyle(fontSize: 25.0,color:Colors.black, fontWeight: FontWeight.bold,),),

                              
                                            // decoration: new BoxDecoration(

                                               
                                              
                                      
                                                  child: new Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
 
                          Image.network('http://fluttertest.000webhostapp.com/upload/${data[index]["img_name"]}',width: 150.0,height: 100.0,
                            alignment: Alignment.center,fit: BoxFit.fitWidth),
                                  SizedBox(
                                    width: 20.0,height: 15.0),                              
                                                              
                                                    new Container(

                                                    
                                                    child: Text("${data[index]['product_name']}",  
                                            style:new TextStyle(fontSize: 20.0,color:Colors.redAccent, fontWeight: FontWeight.bold,),), 
                                          // Theme.of(context).textTheme.headline)
                                                  ),],) 
                                        
                                                
                                            
                                            // new TextStyle(fontSize: 20.0,color:Colors.redAccent, fontWeight: FontWeight.bold,),),
                                    
                                          //Sizedbox()
                    //  backgroundColor: Colors.black
                                              ),
                                    
                                                
                                            ),
                                            
                                            
                                          ),
                                          
                                            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                                        builder: (BuildContext context) => new ProductDisp(
                                              list: data,
                                              index: index,
                                            ))),
                                            );
                                      },
                                    ), */
        return new   ListView.builder(
          scrollDirection: Axis.vertical,
             shrinkWrap: true,                
                                      
             //scrollDirection: Axis.vertical,
           //     shrinkWrap: true,
                  itemCount: widget.list == null ? 0 : widget.list.length,
          itemBuilder: (context, i) {
                   return new Container(  
                      //width: double.infinity,
                      width: 115,
                    // height: 200.0,
                     // padding: const EdgeInsets.all(10.0),
              child:         new SingleChildScrollView(
                      child: new GestureDetector(
                        onTap: () {
                        //  print("hai"+i.toString());
                           Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Categories_data(
                                  list: widget.list,
                                  index: i,
                                )));
                                },
                      
                        child: new Card(
                             //   color: Colors.amber,
                          child: new ListTile(
                           // isThreeLine: true,
                           
                             title: 
                         
                            Text("${widget.list[i]['category']}",style: new TextStyle(fontSize: 15.0,color:Colors.blue,fontWeight: FontWeight.bold),),
                         //  trailing: Text("Price : Rs${widget.list[i]['product_price']}",style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                      //    leading: Icon(Icons.category),

                        
                             
                       /* leading: 
                                        CircleAvatar(
                               // radius: 40.0,
                                //minRadius: 10.0,
                                maxRadius: 30.0,
                                backgroundImage:
                                  NetworkImage("http://fluttertest.000webhostapp.com/upload/${widget.list[i]['img_name']}"),
                                  //  NetworkImage("http://192.168.122.1/ecart/upload/${widget.list[i]['img_name']}"),
                                backgroundColor: Colors.transparent,
                                        ),*/

                        
                             
      
 
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
 