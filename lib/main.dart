import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempahankuih/Model/User.dart';
import 'package:tempahankuih/Services/Wrapper.dart';
import 'package:tempahankuih/Services/user_auth.dart';
import 'package:tempahankuih/View/booking_page.dart';
import 'package:tempahankuih/View/gallery_page.dart';
import 'package:tempahankuih/View/home_admin.dart';
import 'package:tempahankuih/View/home_staff.dart';
import 'package:tempahankuih/View/home_user.dart';
import 'package:tempahankuih/View/login.dart';
import 'package:tempahankuih/View/manage_gallery.dart';
import 'package:tempahankuih/View/manage_order.dart';
import 'package:tempahankuih/View/manage_user.dart';
import 'package:tempahankuih/View/register.dart';
import 'package:tempahankuih/View/order_page.dart';
import 'package:tempahankuih/View/profile.dart';
import 'package:tempahankuih/View/register_staff.dart';
void main() {
  // AwesomeNotifications().initialize(
  //   null, 
  //   [
  //     NotificationChannel(
  //       channelKey: 'basic_channel',
  //       channelName : 'Smart Queue Notification',
  //       defaultColor: Colors.teal,
  //       importance: NotificationImportance.High,
  //       channelShowBadge: true,
  //     )
  //   ]
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: UserAuth().user,
      child: MaterialApp(
        // MaterialApp contains our top-level Navigator
        home: Wrapper(),
        routes: {
          '/login': (context) => Login(),
          '/home_user': (context) =>HomePageUser(),
          '/home_admin': (context) => HomePageAdmin(),
          '/home_staff': (context) => HomePageStaff(),
          '/gallery': (context) => GalleryPage(),
          '/booking': (context) => Booking(),
          '/view_order':(context) => OrderPage(),
          '/manage_order':(context) => ManageOrder(),
          '/manage_gallery':(context) =>ManageGallery(),
          '/manage_user':(context) =>ManageUser(),
          '/register':(context) =>RegisterUser(),
          '/register_staff':(context) =>RegisterStaff(),
          '/profile': (context) =>UserProfile()
        },
      ),
    );
  }
}