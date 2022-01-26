import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahankuih/Animation/clipper.dart';
import 'package:tempahankuih/Controller/user_controller.dart';
import 'package:tempahankuih/Model/User.dart';
import 'package:tempahankuih/View/loading.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
              'Your Profile',
              style: TextStyle(
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.bold,
                fontSize: 23.5,
                color: Colors.white
              ),
            ),
          ),
          body: Builder(
            builder: (context) => UserProfilePage(),
          )
      ),
      ],
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _fname;
  String _lname;
  String _idnum;
  String _phone;
  
  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: UserController(userId: userSession.userId).userData,
      builder: (context, snapshot) {
        // print(snapshot.data);
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Center(
            child: SingleChildScrollView(
            child: Container(
              height : MediaQuery.of(context).size.height*.75,
              width  : MediaQuery.of(context).size.width*.9,
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
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0, left: 15.0),
                        child: 
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: MediaQuery.of(context).size.height*.06),
                                Text(
                                  'First Name :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFFFF0000)
                                  ),
                                ),
                                //SizedBox(height: 10.0),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                  initialValue: userData.fName,
                                  validator: (val) => val.isEmpty? 'Enter your first name' : null,
                                  onChanged: (val) {
                                    setState(() => _fname = val);
                                  } 
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  'Last Name :',
                                  style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFFFF0000)
                                  ),
                                ),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                  initialValue: userData.lName,
                                  validator: (val) => val.isEmpty ? 'Enter your last name' : null,
                                  onChanged: (val) {
                                    setState(() => _lname = val);
                                  } 
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  'IC Number :',
                                  style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFFFF0000)
                                  ),
                                ),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                  initialValue: userData.idNum,

                                  validator: (val) => val.isEmpty ? 'Enter your IC number' : null,
                                  onChanged: (val) {
                                    setState(() => _idnum = val);
                                  } 
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  'Phone Number :',
                                  style: TextStyle(
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFFFF0000)
                                  ),
                                ),
                                TextFormField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                  initialValue: userData.phoneNumber,
                                  validator: (val) => val.isEmpty  ? 'Enter your phone number' : null,
                                  onChanged: (val) {
                                    print(userData.phoneNumber);
                                    setState(() => _phone = val);
                                  } 
                                ),
                                
                                SizedBox(height: MediaQuery.of(context).size.height*.06),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      //setState(() => loading = true);
                                      await UserController(userId: userSession.userId).updateUserData(
                                        _fname ?? userData.fName, 
                                        _lname ?? userData.lName, 
                                        _idnum ?? userData.idNum, 
                                        _phone ?? userData.phoneNumber
                                      );
                                      _showProfileUpdatedDialog(context);
                                      //createQueueReadyNotifications();
                                    } 

                                  },
                                  child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFF0000),
                                        Color(0xFFFF0000),
                                      ]
                                    )
                                  ),
                                  child: Center(
                                    child: Text("Update Profile", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                                // ButtonTheme(
                                //   minWidth: 200,
                                //   height: 50,
                                //   child: RaisedButton(
                                //     color: Color.fromRGBO(191, 122, 105, 1),
                                //     child: Text(
                                //       'Update Profile',
                                //       style: TextStyle(color: Colors.white),
                                //     ),
                                //     onPressed: () async {
                                //       if (_formKey.currentState.validate()) {
                                //         //setState(() => loading = true);
                                //         // await UserController(userId: userSession.userId).updateUserData(
                                //         //   _name ?? userData.name, 
                                //         //   _queue ?? userData.queueNumber,
                                //         //   _phone ?? userData.phoneNumber, 
                                //         // );
                                //         Navigator.pop(context);
                                //       } 
                                //       // print(_username);
                                //       // print(_firstname);
                                //       // print(_lastname);
                                //       // print(_email);
                                //       // print(_password);
                                //     },
                                //   ),
                                // ),
                                SizedBox(height: 10.0),
                                // Text(
                                //   'dsadadsad',
                                //   // error,
                                //   style: TextStyle(color: Colors.red, fontSize: 14.0),
                                // )
                              ],
                            )
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        }
        else{
          return Loading();
        }
      }
    );
  }

}

void _showProfileUpdatedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Successful", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
        content: new Text("Profile Updated", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          new FlatButton(
            child: new Text("OK", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}