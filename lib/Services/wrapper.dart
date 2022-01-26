import 'package:flutter/material.dart';
import 'package:tempahankuih/Controller/user_controller.dart';
import 'package:tempahankuih/Model/User.dart';
import 'package:provider/provider.dart';
import 'package:tempahankuih/View/home_admin.dart';
import 'package:tempahankuih/View/home_staff.dart';
import 'package:tempahankuih/View/home_user.dart';
import 'package:tempahankuih/View/login.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<User>(context);
    if(userSession == null){
      return Login();
    }
    else return StreamBuilder<UserData>(
      stream: UserController(userId: userSession.userId).userData,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          print(userData.role);
          if(userData.role == 'admin'){
            return HomePageAdmin();
          }
          if(userData.role == 'user'){
            print('inside user home');
            return HomePageUser();
          }
          if(userData.role == 'staff'){
            print('inside staff home');
            return HomePageStaff();
          }
        }
        return Login();
      });

  }
}