import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahankuih/Animation/clipper.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:tempahankuih/Controller/booking_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageOrder extends StatefulWidget {
  //const ManageOrder({ Key? key }) : super(key: key);

  @override
  _ManageOrderState createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder> {
  String statusUpdate;

  getUserInfo(String userID) async{
    print('userid : $userID');
    List<String> userInfo;
    String userName;
    String firstName;
    String lastName;
    String contactNo;
    DocumentSnapshot documentSnapshot = await Firestore.instance.collection('user').document(userID).get();
    userName = documentSnapshot.data['first_name'];
    print(documentSnapshot);
    //return documentSnapshot.data;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
        ClipShadow(
            clipper: CustomAppBar(),
            boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 15.0,
                    color: Color.fromRGBO(196, 196, 196, 1),
                  )
                ],
            child: Container(
              height: MediaQuery.of(context).size.height*.35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF0000),
                    Color(0xFFFF0000),
                  ]
                ),
              )
            )  
          ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              'Your Order',
              style: TextStyle(
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.bold,
                fontSize: 23.5,
                color: Colors.white
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: BookingController().getAllTempahanKuih(),
              builder:  (BuildContext context, snapshot) {
                if(snapshot.data.length == 0){
                  return Container(
                    height : MediaQuery.of(context).size.height*0.8,
                    width  : MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Your Order is Empty',
                          style: TextStyle(
                            fontFamily: 'Oxygen',
                            fontSize: 25.5,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  );
                }
                
                else return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      statusUpdate = snapshot.data[index].data['status'];
                      if(snapshot.data[index].data['item_id'] == null)
                      {
                        print('in empty cart');
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Your Order is Empty',
                                style: TextStyle(
                                  fontFamily: 'Oxygen',
                                  fontSize: 20.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        );
                      }
                      else {
                      
                      return FutureBuilder(
                        future: Firestore.instance.collection('user').document(snapshot.data[index].data['user_id'].toString()).get(),
                        builder: (_, dataSnap) {
                          print('document data');
                          print(snapshot.data[index].documentID.toString());
                          print(dataSnap.data['first_name']);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            height : MediaQuery.of(context).size.height*.2,
                            width  : MediaQuery.of(context).size.width*.8,
                            child: Card(
                              elevation: 10.0,
                              color: Colors.white,
                              margin: EdgeInsets.all(12.0),   
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.transparent,
                                  width: 10.5,
                                  style: BorderStyle.solid,
                                ),
                              borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                      //Navigator.push(context, BouncyPageRoute(widget: widget.pageRoute));
                                      //Navigator.pushNamed(context, widget.pageRoute);
                                  });
                                },
                                splashColor: Color(0xFFff512f),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left : 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      //SizedBox(width: MediaQuery.of(context).size.width*.03,),
                                      Flexible(
                                        flex: 7,
                                        fit: FlexFit.tight,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                          Text(
                                            snapshot.data[index].data['order_name'],
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              fontSize: 18.5,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFFF0000),
                                            ),
                                          ),
                                          Text(
                                            'Quantity'+' : '+snapshot.data[index].data['quantity'].toString() +' tray(s)',
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              fontSize: 14.5,
                                              color: Color(0xFFFF0000),
                                            ),
                                          ),
                                          Text(
                                            'Customer'+' : '+dataSnap.data['first_name'].toString() + ' '+dataSnap.data['last_name'].toString() ,
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              fontSize: 14.5,
                                              color: Color(0xFFFF0000),
                                            ),
                                          ),
                                           Text(
                                            'Contact'+' : '+dataSnap.data['phone_num'].toString(),
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              fontSize: 14.5,
                                              color: Color(0xFFFF0000),
                                            ),
                                          )
                                        ],),
                                      ),
                                      Flexible(
                                        flex: 4,
                                        fit: FlexFit.tight,
                                        child: (snapshot.data[index].data['status'].toString() == 'Booked')?FlatButton(
                                          onPressed: (){
                                            setState(() {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: new Text("Confirmation", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                                                    content: new Text("Press OK to Update Status", style: TextStyle(color: Colors.black, fontSize: 14)),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        child: new Text("OK", style: TextStyle(color: Colors.black, fontSize: 15)),
                                                        onPressed: () {
                                                          BookingController().updateTempahanStatus(snapshot.data[index].documentID,'Preparing');
                                                          Navigator.of(context).pop();
                                                          setState(() {
                                                            statusUpdate = 'Preparing';
                                                          });
                                                        },
                                                      ),
                                                      new FlatButton(
                                                        child: new Text("Cancel", style: TextStyle(color: Color(0xFFFF0000), fontSize: 15)),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                            
                                          },
                                          color: Colors.amber[700],
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                            Text(
                                              'Preparing',
                                              style: TextStyle(
                                                fontFamily: 'Oxygen',
                                                fontSize: 15.5,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],),
                                        ):(snapshot.data[index].data['status'].toString() == 'Preparing')?FlatButton(
                                          onPressed: (){
                                            setState(() {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: new Text("Confirmation", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                                                    content: new Text("Press OK to Update Status", style: TextStyle(color: Colors.black, fontSize: 14)),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                        child: new Text("OK", style: TextStyle(color: Colors.black, fontSize: 15)),
                                                        onPressed: () {
                                                          BookingController().updateTempahanStatus(snapshot.data[index].documentID,'Ready Pickup');
                                                          Navigator.of(context).pop();
                                                          setState(() {
                                                            statusUpdate = 'Ready Pickup';
                                                          });
                                                        },
                                                      ),
                                                      new FlatButton(
                                                        child: new Text("Cancel", style: TextStyle(color: Color(0xFFFF0000), fontSize: 15)),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                            
                                          },
                                          color: Colors.blue[700],
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                            Text(
                                              'Ready Pickup',
                                              style: TextStyle(
                                                fontFamily: 'Oxygen',
                                                fontSize: 15.5,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],),
                                        ):(snapshot.data[index].data['status'].toString() == 'Ready Pickup')?Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                flex: 2,
                                                child: Text(
                                                  'Waiting for Pickup',
                                                  style: TextStyle(
                                                    fontFamily: 'Oxygen',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.5,
                                                    color: Colors.pink[400],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.timer,
                                                  size: 20,
                                                  color: Colors.pink[400]
                                                ),
                                              )
                                            ],
                                          ),
                                        ):Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Flexible(
                                                flex: 2,
                                                child: Text(
                                                  'Order Received',
                                                  style: TextStyle(
                                                    fontFamily: 'Oxygen',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.5,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.check_circle,
                                                  size: 20,
                                                  color: Colors.green
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      );
                      }
                    }
                );
              },
            )
          )
      ),
      ],
    );
  }
}
