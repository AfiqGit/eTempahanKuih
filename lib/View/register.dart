import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahankuih/Animation/animation.dart';
import 'package:tempahankuih/Services/user_auth.dart';
import 'package:tempahankuih/View/loading.dart';

class RegisterUser extends StatefulWidget {
  //const RegisterUser({ Key? key }) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  String _email, _password, fname, lname, idnum;
  UserAuth _auth = UserAuth();
  bool loading = false;

  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      	child: Container(
	        child: Form(
            key: _formKey,
            child: Column(
	            children: <Widget>[
	              Padding(
	                padding: const EdgeInsets.only(top: 40.0),
	                child: FadeAnimation(
                  2,
                  Container(
	                    height: MediaQuery.of(context).size.height*0.4,
	                    decoration: BoxDecoration(
	                      image: DecorationImage(
	                        image: AssetImage('images/login_pic.png'),
                    //colorFilter: ColorFilter.mode(Color(0xFFf36650), BlendMode.),
	                        fit: BoxFit.fill
	                      )
	                    ),
	                  ),
	                ),
	              ),
	              Padding(
	                padding: EdgeInsets.all(30.0),
	                child: Column(
	                  children: <Widget>[
	                    FadeAnimation(1.8, Container(
	                      padding: EdgeInsets.all(5),
	                      decoration: BoxDecoration(
	                        color: Colors.white,
	                        borderRadius: BorderRadius.circular(10),
	                        boxShadow: [
	                          BoxShadow(
	                            color: Color.fromRGBO(243, 102, 80, .3),
	                            blurRadius: 20.0,
	                            offset: Offset(0, 10)
	                          )
	                        ]
	                      ),
	                      child: Column(
	                        children: <Widget>[
	                          Container(
	                            padding: EdgeInsets.all(8.0),
	                            decoration: BoxDecoration(
	                              border: Border(bottom: BorderSide(color: Colors.grey[100]))
	                            ),
	                            child: TextFormField(
                                onSaved: (input) => fname = input,

	                              decoration: InputDecoration(
	                                border: InputBorder.none,
	                                hintText: "First Name",
	                                hintStyle: TextStyle(color: Colors.grey[400])
	                              ),
	                            ),
	                          ),
                          Container(
	                            padding: EdgeInsets.all(8.0),
	                            decoration: BoxDecoration(
	                              border: Border(bottom: BorderSide(color: Colors.grey[100]))
	                            ),
	                            child: TextFormField(
                                onSaved: (input) => lname = input,

	                              decoration: InputDecoration(
	                                border: InputBorder.none,
	                                hintText: "Last Name",
	                                hintStyle: TextStyle(color: Colors.grey[400])
	                              ),
	                            ),
	                          ),
                          Container(
	                            padding: EdgeInsets.all(8.0),
	                            decoration: BoxDecoration(
	                              border: Border(bottom: BorderSide(color: Colors.grey[100]))
	                            ),
	                            child: TextFormField(
                                onSaved: (input) => idnum = input,

	                              decoration: InputDecoration(
	                                border: InputBorder.none,
	                                hintText: "IC Number",
	                                hintStyle: TextStyle(color: Colors.grey[400])
	                              ),
	                            ),
	                          ),
                          Container(
	                            padding: EdgeInsets.all(8.0),
	                            decoration: BoxDecoration(
	                              border: Border(bottom: BorderSide(color: Colors.grey[100]))
	                            ),
	                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) {
                                    Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if(!regex.hasMatch(input)){
                                      return "Enter a valid email";
                                    }
                                    else
                                      return null;
                              },
                              onSaved: (input) => _email = input,

	                            decoration: InputDecoration(
	                                border: InputBorder.none,
	                                hintText: "Email",
	                                hintStyle: TextStyle(color: Colors.grey[400])
	                              ),
	                            ),
	                          ),
	                          Container(
	                            padding: EdgeInsets.all(8.0),
	                            child: TextFormField(
                                controller: _pass,
                                obscureText: true,
                                validator: (input){
                                    if(input.length < 6){
                                      return 'Password must be atleast 6 characters';
                                    }
                                    else
                                      return null;
                                },
                                onSaved: (input) => _password = input,

	                              decoration: InputDecoration(
	                                border: InputBorder.none,
	                                hintText: "Password",
	                                hintStyle: TextStyle(color: Colors.grey[400])
	                              ),
	                            ),
	                          ),
                          Container(
	                            padding: EdgeInsets.all(8.0),
	                            child: TextFormField(
                                controller: _confirmPassword,
                                obscureText: true,
                                validator: (input){
                                      if(input.length < 6){
                                        return 'Password must be atleast 6 character';
                                      }
                                      else if(input != _pass.text)
                                        return 'Password not match';
                                      else
                                        return null;
                                },
	                              decoration: InputDecoration(
	                                border: InputBorder.none,
	                                hintText: "Confirm Password",
	                                hintStyle: TextStyle(color: Colors.grey[400])
	                              ),
	                            ),
	                          )
	                        ],
	                      ),
	                    )),
	                    SizedBox(height: 30,),
	                    FadeAnimation(
                      2, 
                      GestureDetector(
                        onTap: ()async{
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            setState(() {
                              loading= true;
                            });
                            dynamic result = await _auth.signUp(_email, _password, fname, lname, idnum, 'user');
                            if(result != null){
                              setState(() {
                                loading = false;
                                print(result.toString());
                              });
                              _showExistingUserDialog(context);
                            }
                            if(result == null){
                              setState(() {
                              loading= false;
                              Navigator.pop(context);
                            });
                            }
                            print(result);
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
	                        child: Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
	                      ),
	                    ),
                    )
                  ),
	                  ],
	                ),
	              )
	            ],
	          ),
	        ),
	      ),
      )
    );
  }
}

void _showExistingUserDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("User Already Exists", style: TextStyle(color: Color(0xFFFF0000), fontSize: 15, fontWeight: FontWeight.bold)),
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