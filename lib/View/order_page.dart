import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:tempahankuih/Animation/clipper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tempahankuih/Controller/booking_controller.dart';
import 'dart:async';
import 'package:tempahankuih/Controller/gallery_controller.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tempahankuih/Model/User.dart';

class OrderPage extends StatefulWidget {
  //const OrderPage({ Key? key }) : super(key: key);
  final String galleryID;
 

  OrderPage({Key key, this.galleryID}): super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}


class _OrderPageState extends State<OrderPage> {
  // int _counter = 1;
  // int _newVal =1;
  // int _minValue = 1;
  // int _maxValue = 20;

  // getImageFromStorage() async{
  //   print('in get image');
  //   final ref = FirebaseStorage.instance.ref().child("nasi.jpg");
  //   var url = await ref.getDownloadURL();
  //   print('url image');
  //   print(url.toString());
  //   return url;
  // }

  // void _incrementCounter(){
  //   setState(() {
  //     _counter++;
  //   });
  // }

  // void _decrementCounter(){
  //   setState(() {
  //     _counter++;
  //   });
  // }

  // String _fetchCounter(){
  //   setState(() {
  //     return _counter.toString();
  //   });
  // }

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

            child: FutureBuilder(
                future: GalleryController().getImageURL(widget.galleryID),
                builder: (_, snapshot) {
                  return Container(
                    height: MediaQuery.of(context).size.height*.35,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                      image: NetworkImage(snapshot.data.toString()),
                      fit: BoxFit.fill,
                      ),
                    )
                  );
                })
          ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              'Order Now',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.5,
                color: Colors.white
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: GalleryController().getSingleGallery(widget.galleryID),
               builder: (_, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height*.25),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        snapshot.data[0],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.5,
                          color: Colors.black
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
                          child: SmoothStarRating(
                            rating: double.parse(snapshot.data[3]),
                            size: 18,
                            starCount: 5,
                            isReadOnly:true,
                            color: Color(0xFFFF0000),
                          )
                        ),
                        Container(
                          padding: EdgeInsets.only( right: 10.0, bottom: 20.0),
                          child: Text(
                            snapshot.data[4] +' review(s)',
                              style: TextStyle(
                              fontSize: 16.5,
                              color: Colors.black
                          ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Description:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5,
                              color: Colors.black
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            snapshot.data[1],
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 14.5,
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top:20, left: 10, right: 10, bottom: 10),
                      child: Text(
                        'User Reviews',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.5,
                          color: Colors.black
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: GalleryController().getUserReview(widget.galleryID),
                      builder: (_, snapshot) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            if(snapshot.data[index].data['user_review'] == null){
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'No Review',
                                  style: TextStyle(
                                      fontSize: 14.5,
                                      color: Colors.black
                                    ),
                                  ),
                              );
                            }
                            else return Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children : <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Text(
                                          snapshot.data[index].data['user_review'],
                                          style: TextStyle(
                                            fontSize: 14.5,
                                            color: Colors.black
                                          ),
                                        ),
                                      ),
                                      //SizedBox(width: MediaQuery.of(context).size.width*.5),
                                      SmoothStarRating(
                                        rating: double.parse(snapshot.data[index].data['rating'].toString()),
                                        size: 12,
                                        starCount: 5,
                                        isReadOnly:true,
                                        color: Color(0xFFFF0000),
                                      ),
                                      // Text(
                                      //   snapshot.data[index].data['rating'].toString(),
                                      //   style: TextStyle(
                                      //     fontSize: 14.5,
                                      //     color: Colors.black
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                        );
                      }
                    )
                  ],
                );
              }
            ),
          ),
          
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            builder: (context) => MyBottomSheet(galleryID: widget.galleryID),
          );
        },
            label: Text('Order Now'),
            backgroundColor: Color(0xFFFF0000),
          )
        )
      ]
    );
  }
}

class MyBottomSheet extends StatefulWidget {

final String galleryID;
  MyBottomSheet({Key key, this.galleryID}): super(key: key);

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {

  int _counter = 1;
  int _newVal =1;
  int _minValue = 1;
  int _maxValue = 20;

  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<User>(context);
    return Container(
                height: 200,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  'Quantity (tray)',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.5,
                                    ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width*.25),
                                IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
                                  iconSize: 20.0,
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    setState(() {
                                      if (_counter > _minValue) {
                                        _counter--;
                                        //GalleryController().updateGalleryReview('1WzWI5xvn3xwJn3HMS6y', 'good kuih', 4);
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  '$_counter',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.5,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
                                  iconSize: 20.0,
                                  color:Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      if (_counter < _maxValue) {
                                        _counter++;
                                        //GalleryController().addGalleryKuih('Karipap Panas', 'sedap dibuat fresh', 'abc/abc');
                                        //GalleryController().getData();
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      RaisedButton(
                        color: Color(0xFFFF0000),
                        child: const Text(
                            'Order Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.5,
                            ),
                          ),
                        onPressed: () {
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
                                        BookingController().addTempahanKuih(userSession.userId, widget.galleryID, _counter);
                                        Navigator.of(context).pop();
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
                      )
                    ],
                  ),
                ),
              );
  }
}

void _showExistingUserDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Confirmation", style: TextStyle(color: Color(0xFFFF0000), fontSize: 15, fontWeight: FontWeight.bold)),
        content: new Text("Please Try Different Email", style: TextStyle(color: Color(0xFFFF0000), fontSize: 14, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          new FlatButton(
            child: new Text("OK", style: TextStyle(color: Color(0xFFFF0000), fontSize: 15, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}