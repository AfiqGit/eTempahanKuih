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

class HomePageUser extends StatefulWidget {
  // final FirebaseUser user;
  // const HomePageUser({Key key, this.user}) : super(key: key);
  //const HomePageUser({ Key? key }) : super(key: key);

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
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
                      Navigator.push(context, BouncyPageRoute(widget: Booking()));
                      //  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                  IconButton(
                    onPressed: () async{
                      // Navigator.pushNamed(context, '/login');
                      Navigator.push(context, BouncyPageRoute(widget: ManageOrder()));
                      //  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                    },
                    icon: Icon(Icons.person),
                  ),
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
            builder: (context) => HomePage(),
          )
      ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<User>(context);
    return Column(
          children: <Widget>[
            //SizedBox(height:MediaQuery.of(context).size.height*0.26),
            Text(
              'Discover Our Delicious Kuih' ,
              style: TextStyle(
              //fontWeight: FontWeight.w200,
              fontSize: 16.5,
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
              child: FutureBuilder(
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
                                Navigator.push(context, BouncyPageRoute(widget: OrderPage(galleryID: snapshot.data[index].documentID)));
                                //Navigator.pushNamed(context, widget.pageRoute);
                                //print(snapshot.data[index].documentID);
                                //GalleryController().getSingleGallery(snapshot.data[index].documentID);
                                //print(snapshot.data[index].data['title']);
                            });
                          },
                          splashColor: Color(0xFFff512f),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
                              child: Row(
                                //mainAxisSize: MainAxisSize.max,
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Flexible(
                                    flex: 2,
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
                                    flex: 1,
                                    child:Text(
                                    snapshot.data[index].data["title"],
                                      style: TextStyle(
                                        fontFamily: 'Oxygen',
                                        fontSize: 18.5,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF0000),
                                      ),
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
            ),
          ],
        );
  }
}