import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahankuih/Animation/clipper.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:tempahankuih/Controller/gallery_controller.dart';
import 'package:tempahankuih/Model/User.dart';
import 'package:tempahankuih/Services/user_auth.dart';
import 'package:tempahankuih/Controller/home_controller.dart';
import 'package:tempahankuih/View/booking_page.dart';
import 'package:tempahankuih/View/bouncy_page_route.dart';
import 'package:tempahankuih/View/manage_gallery.dart';
import 'package:tempahankuih/View/manage_order.dart';
import 'package:tempahankuih/View/manage_user.dart';
import 'package:tempahankuih/View/order_page.dart';
import 'package:tempahankuih/View/profile.dart';
import 'package:tempahankuih/View/register_staff.dart';

class HomePageAdmin extends StatefulWidget {
  //const HomePageAdmin({ Key? key }) : super(key: key);

  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  final UserAuth _auth = UserAuth();
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
            automaticallyImplyLeading: false,
            centerTitle: false,
            elevation: 0.0,
            title: Text(
              'Tempahan Kuih',
              style: TextStyle(
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.bold,
                fontSize: 21.5,
                color: Colors.white
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  
                  IconButton(
                    onPressed: () async{
                      // Navigator.pushNamed(context, '/login');
                      await _auth.signOut();
                      //  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                    },
                    icon: Icon(Icons.exit_to_app),
                  ),
                ],
              ),
              
            ],
          ),
          body: Builder(
            builder: (context) => HomePageAdminCreate(),
          )
      ),
      ],
    );
  }
}

class HomePageAdminCreate extends StatefulWidget {
  //const HomePageAdminCreate({ Key? key }) : super(key: key);

  @override
  _HomePageAdminCreateState createState() => _HomePageAdminCreateState();
}

class _HomePageAdminCreateState extends State<HomePageAdminCreate> {
  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            //SizedBox(height:MediaQuery.of(context).size.height*0.26),
            Text(
              'Manage Reservation from your smartphone' ,
              style: TextStyle(
              //fontWeight: FontWeight.w200,
              fontSize: 18.5,
              color: Colors.white
            ),
            ),
            Divider(
              color: Colors.white,
              indent: 100.0,
              endIndent: 100.0,
              thickness: 2.5,
              height: 17.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height*.6,
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            HomeController(titleOne: 'Manage ', titleTwo: 'Order', image: Icons.settings, iconColor: Colors.red, pageRoute: ManageOrder()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            HomeController(titleOne: 'Manage', titleTwo: 'Gallery', image: Icons.settings, iconColor: Colors.red, pageRoute: ManageGallery()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            HomeController(titleOne: 'Manage', titleTwo: 'User', image: Icons.settings, iconColor: Colors.red, pageRoute: ManageUser()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
  }
}