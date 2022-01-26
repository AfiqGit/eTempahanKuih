import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahankuih/Animation/clipper.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tempahankuih/Controller/user_controller.dart';
import 'package:tempahankuih/View/bouncy_page_route.dart';
import 'package:tempahankuih/View/register.dart';
import 'package:tempahankuih/View/register_staff.dart';

class ManageUser extends StatefulWidget {
  //const ManageUser({ Key? key }) : super(key: key);

  @override
  _ManageUserState createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
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
              'Manage User',
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
              future: UserController().getStaffData(),
              builder: (BuildContext context, snapshot) {
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
                      return Container(
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
                                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0, left: 15.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 9,
                                      fit: FlexFit.tight,
                                      child: Column(
                                        //mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Row(children: <Widget>[
                                            Flexible(
                                            flex: 3,
                                            fit: FlexFit.tight,
                                            child: Text(
                                                'Full Name ',
                                                style: TextStyle(
                                                  fontFamily: 'Oxygen',
                                                  fontSize: 15.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFF0000),
                                                ),
                                              )
                                            ),
                                            Flexible(
                                            flex: 6,
                                            fit: FlexFit.tight,
                                            child: Text(
                                                ': '+snapshot.data[index].data['first_name'] + " " + snapshot.data[index].data['last_name'],
                                                style: TextStyle(
                                                  fontFamily: 'Oxygen',
                                                  fontSize: 15.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFF0000),
                                                ),
                                              )
                                            ),
                                          ],
                                          ),
                                          Row(children: <Widget>[
                                            Flexible(
                                            flex: 3,
                                            fit: FlexFit.tight,
                                            child: Text(
                                                'ID Number',
                                                style: TextStyle(
                                                  fontFamily: 'Oxygen',
                                                  fontSize: 15.5,
                                                  color: Color(0xFFFF0000),
                                                ),
                                              )
                                            ),
                                            Flexible(
                                            flex: 6,
                                            fit: FlexFit.tight,
                                            child: Text(
                                                ': '+snapshot.data[index].data['id_number'],
                                                style: TextStyle(
                                                  fontFamily: 'Oxygen',
                                                  fontSize: 15.5,
                                                  color: Color(0xFFFF0000),
                                                ),
                                              )
                                            ),
                                          ],
                                          ),
                                          Row(children: <Widget>[
                                            Flexible(
                                            flex: 3,
                                            fit: FlexFit.tight,
                                            child: Text(
                                                'Phone No.',
                                                style: TextStyle(
                                                  fontFamily: 'Oxygen',
                                                  fontSize: 15.5,
                                                  color: Color(0xFFFF0000),
                                                ),
                                              )
                                            ),
                                            Flexible(
                                            flex: 6,
                                            fit: FlexFit.tight,
                                            child: Text(
                                                ': '+snapshot.data[index].data['phone_num'],
                                                style: TextStyle(
                                                  fontFamily: 'Oxygen',
                                                  fontSize: 15.5,
                                                  color: Color(0xFFFF0000),
                                                ),
                                              )
                                            ),
                                          ],
                                          ),

                                        ],
                                      ),
                                    ),

                                    Flexible(
                                      flex: 2,
                                      fit: FlexFit.loose,
                                      child: FlatButton(
                                        
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
                                                          UserController().removeStaffData(snapshot.data[index].documentID.toString());
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
                                    )
                                  ],
                                )
                              )
                            )
                          )
                        )
                      );
                    }
                );
              }
            )
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context, BouncyPageRoute(widget: RegisterStaff()));
            },
            label: Text('Add'),
            backgroundColor: Color(0xFFFF0000),
          ),floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        )
      ]
    );
  }
}