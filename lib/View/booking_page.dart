import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahankuih/Animation/clipper.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:tempahankuih/Controller/booking_controller.dart';
import 'package:tempahankuih/Controller/gallery_controller.dart';
import 'package:tempahankuih/Model/User.dart';
import 'package:tempahankuih/View/bouncy_page_route.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class Booking extends StatefulWidget {
  //const Booking({ Key? key }) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String statusUpdate;
  TextEditingController _textFieldController = TextEditingController();

  bool _canShowButton = true;

  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<User>(context);
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
              future: BookingController().getTempahanKuih(userSession.userId),
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
                      else return Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        height : MediaQuery.of(context).size.height*.18,
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
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    //SizedBox(width: MediaQuery.of(context).size.width*.03,),
                                    Flexible(
                                      flex: 6,
                                      fit: FlexFit.tight,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                          'Quantity: ' +snapshot.data[index].data['quantity'].toString() +' tray(s)',
                                          style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 15.5,
                                            color: Color(0xFFFF0000),
                                          ),
                                        ),
                                        Text(
                                          'Status: ' +snapshot.data[index].data['status'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Oxygen',
                                            fontSize: 15.5,
                                            color: Color(0xFFFF0000),
                                          ),
                                        )
                                      ],),
                                    ),
                                    Flexible(
                                      flex: 4,
                                      fit: FlexFit.tight,
                                      child: (snapshot.data[index].data['status'].toString() == 'Received')?Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              'Order Received',
                                              style: TextStyle(
                                                fontFamily: 'Oxygen',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.5,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Icon(
                                              Icons.check_circle,
                                              size: 20,
                                              color: Colors.green
                                            )
                                          ],
                                        ),
                                      ):FlatButton(
                                        onPressed: (){
                                          setState(() {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: new Text("Confirmation", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                                                  content: new Text("Press OK to Proceed", style: TextStyle(color: Colors.black, fontSize: 14)),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      child: new Text("OK", style: TextStyle(color: Colors.black, fontSize: 15)),
                                                      onPressed: () {
                                                        BookingController().updateTempahanStatus(snapshot.data[index].documentID,'Received');
                                                        Navigator.of(context).pop();
                                                        setState(() {
                                                          statusUpdate = 'Received';
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              String valueText;
                                                              double ratingUpdate = 5.0;
                                                              return AlertDialog(
                                                                title: new Text("Rate this Kuih", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                                                                content: Container(
                                                                  height: MediaQuery.of(context).size.height*0.2,
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      SmoothStarRating(
                                                                        rating: ratingUpdate,
                                                                        size: 25,
                                                                        starCount: 5,
                                                                        isReadOnly:false,
                                                                        allowHalfRating: false,
                                                                        color: Color(0xFFFF0000),
                                                                        onRated: (value) {
                                                                        //print("rating value -> $value");
                                                                        setState(() {
                                                                          ratingUpdate= value;
                                                                          print("ratingUpdate value $ratingUpdate");
                                                                        });
                                                                        
                                                                       },
                                                                      ),
                                                                      TextField(
                                                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                                                        onChanged: (value) {
                                                                          setState(() {
                                                                            valueText = value;
                                                                          });
                                                                        },
                                                                        controller: _textFieldController,
                                                                        decoration: InputDecoration(
                                                                          hintText: "Comment here",
                                                                        ),
                                                                      )
                                                                    ]
                                                                  ),
                                                                ),
                                                                actions: <Widget>[
                                                                  new FlatButton(
                                                                    child: new Text("Submit", style: TextStyle(color: Colors.black, fontSize: 15)),
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        //print(ratingUpdate);
                                                                        GalleryController().updateGalleryReview(snapshot.data[index].data['item_id'], valueText, ratingUpdate.toInt());
                                                                        Navigator.of(context).pop();
                                                                      });
                                                                    },
                                                                    )
                                                                ]
                                                              );
                                                            }
                                                          );
                                                          
                                                          
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
                                        color: Color(0xFFFF0000),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                          Text(
                                            'Receive Order',
                                            style: TextStyle(
                                              fontFamily: 'Oxygen',
                                              fontSize: 15.5,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
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

