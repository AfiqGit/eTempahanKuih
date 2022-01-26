import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:tempahankuih/Model/User.dart';


class UserController{

  final String userId;
  UserController({this.userId});
  final CollectionReference userCollection = Firestore.instance.collection('user');

  Future registerUserData(String fName, String lName, String idNum, String phone, String role) async{
    return await userCollection.document(userId).setData({
      'first_name'  : fName,
      'last_name'   : lName,
      'id_number'   : idNum,
      'role'        : role,
      'phone_num'    : phone
    });
  }

  Future updateUserData(String fName, String lName, String idNum, String phone) async{
    return await userCollection.document(userId).updateData({
      'first_name'  : fName,
      'last_name'   : lName,
      'id_number'   : idNum,
      'phone_num'    : phone
    });
  }

  Future getStaffData() async{
    QuerySnapshot querySnapshot = await userCollection.where("role", isEqualTo: 'staff').getDocuments();
    // for(int i=0 ; i<querySnapshot.documents.length; i++){
        
    //   print(querySnapshot.documents[i].data);
    // }
    return querySnapshot.documents;
  }

  Future removeStaffData(String userId) async{
    await userCollection.document(userId).updateData({
      'role'  : 'user',
    });
  }



  UserData _userFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      userId: userId,
      fName: snapshot.data['first_name'],
      lName: snapshot.data['last_name'],
      idNum: snapshot.data['id_number'],
      role: snapshot.data['role'],
      phoneNumber: snapshot.data['phone_num'],
      );
  }

  Stream<UserData> get userData{
  return userCollection.document(userId).snapshots().map(_userFromSnapshot);
  }

  // List<UserList> _userListFromSnapshot(QuerySnapshot snapshot){
  //   return snapshot.documents.map((doc){
  //     return UserList(
  //       name: doc.data['name'],
  //       role: doc.data['role']
  //     );
  //   }).toList();
  // }

  // Stream<List<UserList>> get userList{
  //   return userCollection.snapshots().map(_userListFromSnapshot);
  // }

}

