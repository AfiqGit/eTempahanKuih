import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahankuih/Animation/animation.dart';
import 'package:tempahankuih/Services/user_auth.dart';
import 'package:tempahankuih/View/loading.dart';
import 'package:tempahankuih/View/register.dart';
import 'package:tempahankuih/View/bouncy_page_route.dart';

class Login extends StatefulWidget {
  //const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UserAuth _auth = UserAuth();
  String _email, _password;
  String error = '';
  bool loading = false;
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      	child: Container(
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
                    //colorFilter: ColorFilter.mode(Color(0xFFf36650), BlendMode.colorBurn),
	                      //fit: BoxFit.fill
	                    )
	                  ),
	                ),
	              ),
	            ),
	            Padding(
	              padding: EdgeInsets.all(30.0),
	              child: Form(
                  key: _formKey,
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
                              obscureText: true,
                              validator: (input){
                                  if(input.length < 6){
                                    return 'Password must be atleast 6 character';
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
	                          )
	                        ],
	                      ),
	                    )),
	                    SizedBox(height: 30,),
	                    FadeAnimation(
                      2, 
                      GestureDetector(
                        onTap: () async{
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            setState(() {
                              loading = true;
                            });
                            dynamic result =await _auth.signIn(_email, _password);
                            if(result == null){
                             setState(() {
                               error = 'Wrong Email or Password';
                               loading = false;
                             });
                            }
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
	                        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
	                      ),
	                    ),
                    )
                  ),
	                    SizedBox(height: 40,),
	                    FadeAnimation(
                      1.5, 
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            Navigator.push(context, BouncyPageRoute(widget: RegisterUser()));
                            //Navigator.pushNamed(context, '/register');
                          });
                        },
                        child: Text(
                          "Sign Up Now!", 
                          style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      )   
                    ),
	                  ],
	                ),
	              ),
	            )
	          ],
	        ),
	      ),
      )
    );
  }
}