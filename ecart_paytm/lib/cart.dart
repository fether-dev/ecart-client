import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'home1.dart';
import 'main1.dart';
import 'package:ecart_client1/paytm_payments.dart';
class Cart extends StatefulWidget {   
int index;
        final String username;
        List list;
            Cart({this.index,this.list,this.username});
        var p_img; 
      @override
        _CartState createState() => new _CartState();
        //@override
      // _CartDetilsState createState1() => new _CartDetilsState();
              }
      int count;
       Future future;
      class _CartState extends State<Cart> {
        var response;
          Future<List> load_cart() async {
          print('Inside load_cart');
          username = username;
          //  print('FLUTTERUSERNAME'+username);  
          //fluttertest.000webhostapp.com
              response =   await http.get('http://fluttertest.000webhostapp.com/eload_cart.php?username=$username');
          // response =   await http.get('http://192.168.122.1/ecart/load_cart.php?username=$username');
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
        
        @override
        
            Widget build(BuildContext context) {
                List list;
                return Scaffold(
              appBar: AppBar(title: Text("Cart Details"),backgroundColor: Colors.red,
             automaticallyImplyLeading: false,
              ),
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
              //padding: const EdgeInsets.all(8.0),
                Expanded(
                        child: FutureBuilder<List>(
                
                  future: load_cart(),
            
                   builder: (context, snapshot) {   
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new Container(       
                    child:
                    new Column(
                      children: <Widget>[
                   ItemList1(
                      list: snapshot.data,
                     ),
                    new Text("Overall Total: ${snapshot.data[0]['ototal']}", textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700,color: Colors.red,) ),
             
                   new Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                       new RaisedButton(
                        child: new Text("Home", textAlign: TextAlign.center,
                          style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),),
                  color: Colors.lightBlue,
                      onPressed: (){     
                       Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new Fpage(),
                     //  Navigator.pushNamedAndRemoveUntil(context, '/fpage', (_) => false)

                          //Navigator.of(context).pushNamed('/cart');
                  )
                );
                      },
                     ),
                     new Container(
                        width: 100.0,
                       height: 100.0,
                     ),
                      new RaisedButton(
                  child: new Text("Checkout", textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),),
                  color: Colors.lightBlue,
                      onPressed: (){     
                            insert_bill()    {
                          print('Inside insert bill');
                          print('USERNAME'+username);//snapshot.data[0]['ototal']
                        print("snapshot.data[0]['ototal']"+snapshot.data[0]['ototal']);
                             var url="http://fluttertest.000webhostapp.com/einsert_bill.php";
                            //var url="http://192.168.122.1/ecart/insert_bill.php";
                            http.post(url, body: {
                            "username"  : username,
                            "ototal" :snapshot.data[0]['ototal']
                          });
                          
                        }
      insert_bill();
       
        Future<void> initPayment() async {
           print("inside initpayment");
           print("snapshot.data[0]['ototal']"+snapshot.data[0]['ototal']);
    try {
      await PaytmPayments.makePaytmPayment(
        "HSZtRz20664631372837", 
        "https://fluttertest.000webhostapp.com/paytm/generateChecksum.php",
        customerId: username, 
        mobileNumber: "9787591660",
        email: "diya.feb28@gmail.com",
        orderId: DateTime.now().millisecondsSinceEpoch.toString(),
        txnAmount: snapshot.data[0]['ototal'],                       
        channelId: "WAP", 
        industryTypeId: "Retail", 
        website: "APPSTAGING", 
        staging: true, 
        showToast: true, 
      );

    } on Exception {

      print("Some error occurred");
    }
    if (!mounted) return;
  }
      initPayment();
           
                  },),
                     ],
                   ),
                      

                                    ],
                    ),
                    //),
                  )
                  : new Center(
                  child:  new Image.asset('asset/cart.gif',height: 100.0,width: 150.0,),

                    );
            },
 
                      
                
                ),
        
                      
                ),
      // Text("${widget.list[i]['qty']} * ${widget.list[i]['product_price']} = ${data[i]['qty_total']}"),
      
                    
            /*&  new RaisedButton(
                        child: new Text("Checkout", textAlign: TextAlign.center,
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
        
        
      class ItemList1 extends StatefulWidget {
            List list;
            int index; 
        

          ItemList1({this.list,this.index});

        @override
        ItemListState createState() => ItemListState();
        //_ItemListState createState() => _ItemListState();

      }
      
      //class _ItemListState extends State<ItemList>  {
      class ItemListState extends State<ItemList1>  {
      int cart_count;

        int index;
            String order_id;
      String id;

Future future;
              void delete_cart(i){
      // var url="http://192.168.122.1/ecart/delete_cart.php";
      var url="http://fluttertest.000webhostapp.com/edelete_cart.php";

        print('id'+widget.list[i]['id']);
          print('uname'+username);
          http.post(url, body: {
        //"id"   : list[]['id'],
      "id" : widget.list[i]['id'],
      "username"  : username

          });
        setState(() {
                    widget.list.removeAt(i);
                     refresh(); 
                  });
              }

          void gocart(){
                  Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context)=> new Cart(),
                  )
                );
              }
        void confirm (i){
        AlertDialog alertDialog = new AlertDialog(
          content: new Text("Are You sure want to delete '${widget.list[i]['product_name']}'"),
          actions: <Widget>[
            new RaisedButton(
              child: new Text("OK DELETE!",style: new TextStyle(color: Colors.black),),
              color: Colors.blue,
              onPressed: (){
                 delete_cart(i);
                     },
            ),
            new RaisedButton(
              
              child: new Text("CANCEL",style: new TextStyle(color: Colors.black)),
              color: Colors.blueAccent[200],
              onPressed: ()=> Navigator.pop(context),
            ),
          ],
        );
        showDialog(context: context, child: alertDialog);
      }
                 Future<List> load_cart() async {
          print('Inside load_cart from update cart');
          username = username;
          //  print('FLUTTERUSERNAME'+username);  
          //fluttertest.000webhostapp.com
             var response =   await http.get('http://fluttertest.000webhostapp.com/eload_cart.php?username=$username');
          // response =   await http.get('http://192.168.122.1/ecart/load_cart.php?username=$username');
          if (response.statusCode == 200) {
            print('response.body:' + response.body);
          // count=response.body.length;
          //print("count"+count.toString());
            await Future.delayed(Duration(seconds: 2));
           print("response.body"+response.body);
   
            {
                return json.decode(response.body);
                
            }
            
          } else {
            // If that call was not successful, throw an error.
            throw Exception('Failed to load post');
            
          }  
        }
        
        List data=[];
       
        Future update_cart(int i) async {
            print("inside update_cart");   

        /*      print('id'+widget.list[i]['id']);
          print('uname'+username);
          print('controllerqty'+ widget.list[i]['qty']);
          print('price'+widget.list[i]['product_price']);*/
      //print(PRICE*QTY);
      //var res = QTY * PRICE; 
      //print(res);
      //print("qty_total: ${res.toString()}");
      
      // var url="http://192.168.122.1/ecart/update_cart.php";

      final response = await http.post("http://fluttertest.000webhostapp.com/eupdate_cart.php", body: {
            "id" : widget.list[i]['id'],
            "qty" : widget.list[i]['qty'],
            "product_price" : widget.list[i]['product_price'],
            "username"  : username
          });
        this.setState(() {
              data = json.decode(response.body);
                     
            refresh(); 
              print("object");
            });
            //print(data[0]["qty_total"]);
                return "Success!";  
        }
   void refresh(){   
   Navigator.of(context).push(  new MaterialPageRoute(builder: (BuildContext context)=> new Cart() ,)
    
               );
 }
  
      void initState() {
     
          super.initState();
     
      }
       var tprice, j;
       int qty,price;
        Widget build(BuildContext context) {
        // final items = List<String>.generate(widget.list.length, (i) => "Item $i");
          // new Container(
              var j = int.tryParse(widget.list[0]['qty']);
            //  print(j);
              if (j!=0) {
            //    print("hao j");
               print(j);
         // future = load_cart();
         setState(() {
           future = load_cart();
         });
        } else {
          print("no difference");
        }
               
            return new  Flexible(
              child: Column(
                children: <Widget>[
                     Expanded(
          child: SizedBox(
            height: 200.0,
                 child:    ListView.builder(
                  scrollDirection: Axis.vertical,
                     //shrinkWrap: true,
                        itemCount: widget.list == null ? 0 : widget.list.length,
                itemBuilder: (context, index) {
                        return new Container(  
                          // width: 550.0,
                          // height: 200.0,
                          // padding: const EdgeInsets.all(10.0),
                    child:       new SingleChildScrollView(
                            child: new GestureDetector(
                            /* onTap: () {
                              //  print("hai"+i.toString());
                                Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) => new Cart(
                                        list: widget.list,
                                        index: i,
                                      )));
                              },*/
                            
                              child: new Card(
                            
         // var j=0;
                              //   color: Colors.amber,
                                child: new Column(
                                  children: <Widget>[
                                                       ListTile(
                                //  isThreeLine: true,
                 
                                  title: 
                              
                                  Text("${widget.list[index]['product_name']}",style: new TextStyle(fontSize: 15.0,color:Colors.blue,fontWeight: FontWeight.bold),),
                              //  trailing: Text("Price : Rs${widget.list[i]['total']}",style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                                
                              leading: 
                                              CircleAvatar(
                                      radius: 20.0,
                                      //minRadius: 10.0,
                                    //maxRadius: 20.0,
                                      backgroundImage:
                                        NetworkImage("http://fluttertest.000webhostapp.com/upload/${widget.list[index]['img_name']}"),
                                        //  NetworkImage("http://192.168.122.1/ecart/upload/${widget.list[i]['img_name']}"),
                                      backgroundColor: Colors.transparent,
                                    ),

                              
                                  
                      subtitle  :   
          new Row(
              children: <Widget>[

          int.tryParse(widget.list[index]['qty']) > 1 ? 
          new IconButton(icon: new Icon(Icons.remove),onPressed: ()=>setState((){
            var j = int.tryParse(widget.list[index]['qty']);
                    j--;
                    widget.list[index]['qty']=j.toString();
                                
                    update_cart(index);
             
                   
          }),): new IconButton(icon: new Icon(Icons.remove_shopping_cart),onPressed: (){},),
                        new Text('${widget.list[index]['qty']}',style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                    
                  new IconButton(icon: new Icon(Icons.add),onPressed: ()=>setState((){
            var j = int.tryParse(widget.list[index]['qty']);
                    j++;
                    widget.list[index]['qty']=j.toString();
                  //  Text("${widget.list[i]['qty']} * ${widget.list[i]['product_price']} = ${data[i]['qty_total']}");
                      update_cart(index);
                     
                
                               new Text('${widget.list[index]['qty']}',style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),);
                  
                          }
          ),
          
          ),  
            
                    InkResponse(
                              
                          child:                       
                            Icon(Icons.delete_outline,color: Colors.red,),
                            onTap: (){         
                              //  confirm(i);
                                  delete_cart(index);
                                       update_cart(index);
                                    
                
                          },

                    ),
           
            
              ],
            ),
      trailing:     Text("${widget.list[index]['qty']} * ${widget.list[index]['product_price']} = ${int.tryParse(widget.list[index]['qty']) * int.tryParse(widget.list[index]['product_price'])}", style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),

                      ),
//Text("Total1 ${widget.list[index]['ototal']}",textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700,color: Colors.red,) ),

                                  ],
                                )
                                
             
                    
                    ),
                            ),
                  ),
                
                );  
              // );
              },
              
            
            ),
          )),

               ],
              )
             
            
         );
          
          }

        
      }
      