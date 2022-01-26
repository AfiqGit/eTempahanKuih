import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tempahankuih/View/bouncy_page_route.dart';

class HomeController extends StatefulWidget {
  //const HomeController({ Key? key }) : super(key: key);
  final IconData image;
  final String titleOne;
  final String titleTwo;
  final Color iconColor;
  final Widget pageRoute;

  HomeController({this.image, this.titleOne, this.titleTwo, this.iconColor, this.pageRoute});
  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height : MediaQuery.of(context).size.height*.18,
      width  : MediaQuery.of(context).size.width*.8,
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
                Navigator.push(context, BouncyPageRoute(widget: widget.pageRoute));
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
                  Icon(
                  widget.image,
                  color: Color(0xFFFF0000),
                  size: 95.5,
                ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                    Text(
                    widget.titleOne,
                    style: TextStyle(
                      fontFamily: 'Oxygen',
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                   Text(
                    widget.titleTwo,
                    style: TextStyle(
                      fontFamily: 'Oxygen',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.5,
                      color: Color(0xFFFF0000),
                    ),
                  ),
                  ]
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}