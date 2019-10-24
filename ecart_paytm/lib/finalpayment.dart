import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'main1.dart';
import 'package:ecart_client1/paytm_payments.dart';

class Cartupdate extends StatefulWidget {

  int index;
  final String username;
   List list;
      Cartupdate({this.index,this.list,this.username});

@override
  _CartupdateState createState() => new _CartupdateState();

}
class _CartupdateState extends State<Cartupdate> {
  @override
    Future<List> load_cart() async {
    print('Inside load_cart');
    //await Future.delayed(Duration(seconds: 2));
     username = username;
      print('FLUTTERUSERNAME'+username);
final response =
       await http.get('http://fluttertest.000webhostapp.com/eload_cart.php?username=$username');
   // final response = await http.get('http://192.168.122.1/ecart/load_cart.php?username=$username');
       // print(response.statusCode);
    if (response.statusCode == 200) {
      print('response.body:' + response.body);
       await Future.delayed(Duration(seconds: 0));
      
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
          //     Size screenSize = MediaQuery.of(context).size;
     return Scaffold(
          appBar: new AppBar(title: new Text('Payment Details'),backgroundColor: Colors.red,),
                  resizeToAvoidBottomPadding: false,
          
       body:
      // SingleChildScrollView(
 
         new   Container(
              height:600.0,
             child:new Center(
               
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[
      //   Expanded(
          Flexible(
           // Expanded(
        //  padding: const EdgeInsets.all(8.0),
           
            child: FutureBuilder<List>(
            future: load_cart(),
            builder: (context, snapshot) {   
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new Container(       
                  //  child: SingleChildScrollView(     
                    //   height: 100.0,
                           
                    child:
                    new Column(
                      children: <Widget>[
                   Payment(
                      list: snapshot.data,
                    ),
                     new Text("Total: ${snapshot.data[0]['ototal']}", textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700,color: Colors.red,) ),
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
            
            /*Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context)=>new Cartupdate(
                        list :list,
                        //index:i,
                        ),
                       
            )
             );*/
                  },),

                                    ],
                    ),
                    //),
                  )
                  : new Center(
                  child:  new Image.asset('asset/load1.gif',height: 100.0,width: 50.0,),

                    );
            },
 

          ),
            ),
        //  ),
     
                ],
             ),
               
             ),
  
                
       ),
        
        
            // ),
      //),


      );
    }
}


class Payment extends StatefulWidget {

  int index;
  final String username;
   List list;
      Payment({this.index,this.list,this.username});
      
@override
  _PaymentState createState() => new _PaymentState();
}
 
class _PaymentState extends State<Payment> {
  @override
  int i;
        
  Widget build(BuildContext context) {
    
  //return  new Container(
    //height: 500.0,
    //child: SingleChildScrollView(

        //child:new Center(
          
      return new  Flexible(
          
        child:  new ListView.builder(
        scrollDirection: Axis.vertical,
        //shrinkWrap: true,
          itemCount: widget.list == null ? 0 : widget.list.length,
          itemBuilder: (context, i) {

                   return new Container(
                    //width: 50.0,
                   // width: double.infinity,

                    //height: double.infinity,
                    //height: 100.0,
                      //padding: const EdgeInsets.all(10.0),
                    // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),


                   //        child: SingleChildScrollView( 
                   //padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  //  child:  SingleChildScrollView(
                       child:     new GestureDetector(
                           onTap: () {
                        //  print("hai"+i.toString());
                           /*Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Payment(
                                  list: widget.list,
                                  index: i,
                                )));*/
                                },
                       child: new Card(   
                        // color: Colors.amber,         
                          child: new ListTile(
                           title: 
                            
                            Text("${widget.list[i]['product_name']}",style: new TextStyle(fontSize: 15.0,color:Colors.blue,fontWeight: FontWeight.bold),),
                          //  Text("Price : ${widget.list[i]['product_price']}",style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                                                       
                             subtitle:
                        Text("Quantity : ${widget.list[i]['qty']}",style:new TextStyle(fontSize: 15.0,color:Colors.blue,fontWeight: FontWeight.bold),),
                        ///Text("Total : ${widget.list[i]['total']}",style:new TextStyle(fontSize: 15.0,color:Colors.blue,fontWeight: FontWeight.bold),),

                         leading: 
          CircleAvatar(
                                maxRadius: 30.0,
                                backgroundImage:
                                 NetworkImage("http://fluttertest.000webhostapp.com/upload/${widget.list[i]['img_name']}"),
                               //NetworkImage("http://192.168.122.1/ecart/upload/${widget.list[i]['img_name']}"),
                                backgroundColor: Colors.transparent,
                              ),
                              trailing: Text("Total : ${widget.list[i]['total']}",style:new TextStyle(fontSize: 15.0,color:Colors.black,fontWeight: FontWeight.bold),),


                ),
            
              ),

            ),
           // ),     
                     
          );  
         
        },
        )
          
      );
    
   //   ),
    // )
    
    
 //   );
            
  
     // );
      
     
  }

}
