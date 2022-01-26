import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:tempahankuih/Animation/clipper.dart';
import 'package:tempahankuih/Controller/gallery_controller.dart';
import 'package:tempahankuih/View/bouncy_page_route.dart';
import 'package:tempahankuih/View/manage_gallery_add.dart';
import 'package:tempahankuih/View/manage_gallery_edit.dart';
import 'package:tempahankuih/View/order_page.dart';

class ManageGallery extends StatefulWidget {
  //const ManageGallery({ Key? key }) : super(key: key);

  @override
  _ManageGalleryState createState() => _ManageGalleryState();
}

class _ManageGalleryState extends State<ManageGallery> {
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
              'Manage Gallery',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.5,
                color: Colors.white
              ),
            ),
          ),
          body: FutureBuilder(
                future: GalleryController().getData(),
                builder: (_, snapshot) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return Container(
                      height : MediaQuery.of(context).size.height*.2,
                      width  : MediaQuery.of(context).size.width*.4,
                      child: Card(
                        elevation: 15.0,
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
                                //Navigator.push(context, BouncyPageRoute(widget: OrderPage(galleryID: snapshot.data[index].documentID)));
                                //Navigator.pushNamed(context, widget.pageRoute);
                                //print(snapshot.data[index].documentID);
                                //GalleryController().getSingleGallery(snapshot.data[index].documentID);
                                //print(snapshot.data[index].data['title']);
                            });
                          },
                          splashColor: Color(0xFFff512f),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
                              child: Row(
                                //mainAxisSize: MainAxisSize.max,
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.loose,
                                    child: Image.network(
                                    snapshot.data[index].data['image_url'],
                                    height: 150,
                                    width: 150,
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.black,
                                    thickness: 2,
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width*.03,),
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child:Text(
                                    snapshot.data[index].data["title"],
                                      style: TextStyle(
                                        fontFamily: 'Oxygen',
                                        fontSize: 18.5,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF0000),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                      flex: 2,
                                      fit: FlexFit.loose,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          FlatButton(
                                            
                                            onPressed: (){
                                              setState(() {

                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: new Text("Confirmation", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                                                      content: new Text("Press OK to Delete", style: TextStyle(color: Colors.black, fontSize: 14)),
                                                      actions: <Widget>[
                                                        new FlatButton(
                                                          child: new Text("OK", style: TextStyle(color: Colors.black, fontSize: 15)),
                                                          onPressed: () {
                                                            setState(() {
                                                              GalleryController().deleteGallery(snapshot.data[index].documentID.toString());
                                                            });
                                                            
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
                                            color: Color(0xFFFF0000),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                              Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 20.0,
                                              )
                                            ],),
                                          ),
                                          FlatButton(
                                            
                                            onPressed: (){
                                              setState(() {
                                                Navigator.push(context, BouncyPageRoute(widget: EditGallery(galleryID: snapshot.data[index].documentID)));
                                              });
                                            },
                                            color: Colors.blueAccent,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                              Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 20.0,
                                              )
                                            ],),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                    }
                  );
                }
              ),
            floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context, BouncyPageRoute(widget: AddGallery()));
            },
            label: Text('Add'),
            backgroundColor: Color(0xFFFF0000),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        )
      ]
    );
  }
}