import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tempahankuih/Animation/clipper.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:tempahankuih/Controller/gallery_controller.dart';
import 'package:tempahankuih/Model/Gallery.dart';
import 'package:tempahankuih/View/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditGallery extends StatefulWidget {
  final String galleryID;
  const EditGallery({ Key key ,this.galleryID}) : super(key: key);

  @override
  _EditGalleryState createState() => _EditGalleryState();
}

class _EditGalleryState extends State<EditGallery> {
  final _formKey = GlobalKey<FormState>();
  String imageUrl;
  String title ;
  String description ;
  File _image;

  Future getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      _image = image;
      print(imageTemp);
    });
  }

  Future uploadImage(String galleryID) async{
    String fileName = basename(_image.path);
    final CollectionReference _galleryCollection = Firestore.instance.collection('gallery_kuih');
    StorageReference firebaseStorage = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadImage = firebaseStorage.putFile(_image);
    StorageTaskSnapshot taskSnapshot=await uploadImage.onComplete;
       

    String urlImage = await firebaseStorage.getDownloadURL();
    print('image url : $urlImage');

    await _galleryCollection.document(galleryID).updateData({
      'image_url' : urlImage,
    });

    setState(() {
      print("Profile Picture uploaded");
      imageUrl = urlImage;
      print("image url : $imageUrl");
    });
    
  }

  

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

            child: FutureBuilder(
                future: GalleryController().getImageURL(widget.galleryID),
                builder: (_, snapshot) {
                  //imageUrl = snapshot.data.toString();
                  return GestureDetector(
                    // onTap: () {
                    //   setState(() {
                    //     imageUrl = snapshot.data.toString();
                    //     //print(imageUrl);
                    //   });
                    // },
                    child: (imageUrl == null)?Container(
                      height: MediaQuery.of(context).size.height*.35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                        image: NetworkImage(snapshot.data.toString()),
                        fit: BoxFit.fill,
                        ),
                      )
                    ):Container(
                      height: MediaQuery.of(context).size.height*.35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                        image: FileImage(_image),
                        fit: BoxFit.fill,
                        ),
                      )
                    ),
                  );
                })
          ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              'Edit Gallery',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.5,
                color: Colors.white
              ),
            ),
          ),
          body: FutureBuilder(
                  future: GalleryController().getSingleGallery(widget.galleryID),
                  builder: (context, snapshot) {
                    // print(snapshot.data);
                    if (snapshot.hasData) {
                      // title = snapshot.data[0];
                      // description = snapshot.data[1];
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
                                              'Title :',
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
                                              initialValue: snapshot.data[0],
                                              validator: (val) => val.isEmpty? 'Enter Title' : null,
                                              onSaved: (val) {
                                                setState(() {
                                                  title = val;
                                                  print(title);
                                                });
                                              } 
                                            ),
                                            SizedBox(height: 20.0),
                                            Text(
                                              'Description :',
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
                                              initialValue: snapshot.data[1],
                                              validator: (val) => val.isEmpty ? 'Enter Description' : null,
                                              onSaved: (val) {
                                                setState(() {
                                                  description = val;
                                                  print(description);
                                                });
                                              } 
                                            ),
                                            SizedBox(height: 20.0),
                                            Text(
                                              'Image :',
                                              style: TextStyle(
                                                fontFamily: 'Oxygen',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Color(0xFFFF0000)
                                              ),
                                            ),
                                            TextFormField(
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.grey),
                                              initialValue: snapshot.data[2],
                                              enabled: false,
                                              validator: (val) => val.isEmpty ? 'Upload Image' : null,
                                              onSaved: (val) {
                                                setState(() {
                                                  
                                                });
                                              } 
                                            ),
                                            SizedBox(height: 10.0),
                                            GestureDetector(
                                              onTap: () async{
                                                
                                                setState(() async{
                                                  await getImage();
                                                });
                                              },
                                              child: Container(
                                                color: Colors.blue,
                                                width: MediaQuery.of(context).size.width*.3,
                                                height:MediaQuery.of(context).size.height*.05,
                                                // onPressed: (){
                                                //   print('hit upload');
                                                // }, 
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      'Upload',
                                                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)
                                                    ),
                                                    Icon(
                                                      Icons.file_upload,
                                                      size: 20.0,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                )
                                              ),
                                            ),
                                            
                                            
                                            SizedBox(height: MediaQuery.of(context).size.height*.06),
                                            GestureDetector(
                                              onTap: () async {
                                                if (_formKey.currentState.validate()) {
                                                  _formKey.currentState.save();
                                                  //setState(() => loading = true);
                                                  await GalleryController().editGallery(title, description, imageUrl, widget.galleryID);
                                                  await uploadImage(widget.galleryID);
                                                  _showProfileUpdatedDialog(context);
                                                  imageUrl = snapshot.data.toString();
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
                                                child: Text("Update Gallery", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ),
                                            SizedBox(height: 10.0),
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
                ),
        )
      ]
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

