class User{
  String userId;
  User({this.userId});
}

class UserData{
  final String userId;
  final String fName;
  final String lName;
  final String idNum;
  final String role;
  final String phoneNumber;

  UserData({this.userId, this.fName, this.lName, this.idNum, this.role, this.phoneNumber});
}

class UserList{
  final String fName;
  final String role;

  UserList({this.fName, this.role});
}