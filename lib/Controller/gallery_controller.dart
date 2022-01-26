import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tempahankuih/Model/Gallery.dart';

class GalleryController{

  final CollectionReference _galleryCollection = Firestore.instance.collection('gallery_kuih');

  Future<String> addGalleryKuih(String title, String description, String imageUrl) async{
    DocumentReference docRef = await _galleryCollection.add({
      'description' : description,
      'title'       : title,
      'image_url'   : imageUrl,
      'rating'      : 0,
      'rating_raw'  : 0,
      'user_review' : 0,
    });

    await _galleryCollection.document(docRef.documentID).collection('user_review').add({

    });
    return docRef.documentID.toString();
  }

  updateGalleryReview(String galleryID, String userReview, int userRating) async{

    await _galleryCollection.document(galleryID).collection('user_review').add({
      'rating'      : userRating,
      'user_review' : userReview
    });


    DocumentSnapshot docSnap = await _galleryCollection.document(galleryID).get();
    //var rating = docSnap.data['rating'];
    var ratingRaw = docSnap.data['rating_raw'];
    var totalReview = docSnap.data['user_review'];
    totalReview = totalReview + 1;
    var ratingRawUpdated = ratingRaw + userRating;
    String averageRatingInString = (ratingRawUpdated/totalReview).toStringAsFixed(1);
    double averageRatingInDouble = double.parse(averageRatingInString);

    await _galleryCollection.document(galleryID).updateData({
      'rating'     : averageRatingInDouble,
      'user_review': totalReview,
      'rating_raw' : ratingRawUpdated,
    });

    print(averageRatingInDouble);
    print(totalReview);
  }


  editGallery(String title, String description, String imageUrl, String galleryID) async{
    await _galleryCollection.document(galleryID).updateData({
      'description' : description,
      'title'       : title,
      'image_url'   : imageUrl,
    });
  }

  deleteGallery(String galleryID) async{
    await _galleryCollection.document(galleryID).delete();
  }

  Future getUserReview(String galleryid) async{
    QuerySnapshot querySnapshot = await _galleryCollection.document(galleryid).collection('user_review').getDocuments();
    print(querySnapshot.documents[0].data['user_review']);
    return querySnapshot.documents;
  }

  GalleryWithReview _galleryFromSnapshot(DocumentSnapshot snapshot, String galleryID){
    return GalleryWithReview(
      galleryId: galleryID,
      title: snapshot.data['title'],
      description: snapshot.data['description'],
      imageUrl: snapshot.data['image_url'],
      totalUserReview: snapshot.data['user_review'],
      rating: snapshot.data['rating'],
      );
  }


   Future getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _galleryCollection.getDocuments();
    for(int i=0 ; i<querySnapshot.documents.length; i++){
      // print(querySnapshot.documents[i].data['title']);
      // print(querySnapshot.documents[i].documentID);
    }
    return querySnapshot.documents;
    // Get data from docs and convert map to List
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    // print(allData);
  }

  Future<String> getImageURL(String galleryID) async{
    String imageUrl;
    await _galleryCollection.document(galleryID).get().then((DocumentSnapshot snapshot){
      imageUrl = snapshot.data['image_url'];
    });

    return imageUrl;
  }

  Future<List<String>> getSingleGallery(String galleryid) async{
    String title, description, imageUrl, rating;
    int totalReview;
    List<String> galleryInfo;
    await _galleryCollection.document(galleryid).get().then((DocumentSnapshot snapshot){
      title       = snapshot.data['title'];
      description = snapshot.data['description'];
      imageUrl    = snapshot.data['image_url'];
      rating      = snapshot.data['rating'].toString();
      totalReview = snapshot.data['user_review'];
    });
    galleryInfo = [title, description, imageUrl, rating, totalReview.toString()];
    print(galleryInfo);
    return galleryInfo;
  }

  // GalleryData _galleryInfoFromSnapshot(DocumentSnapshot snapshot){
  //   return GalleryData(
  //     title : snapshot.data['title'],
  //     description : snapshot.data['description'],
  //     imageUrl : snapshot.data['image_url'],
  //     );
  // }

  // Stream<GalleryData> galleryData(String galleryID) {
  // return  _galleryCollection.document(galleryID).snapshots().map(_galleryInfoFromSnapshot);
  // }


}