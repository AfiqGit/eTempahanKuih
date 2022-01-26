
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tempahankuih/Model/Order.dart';

class BookingController{
    final CollectionReference _bookingCollection = Firestore.instance.collection('tempahan_kuih');
    final CollectionReference _galleryCollection = Firestore.instance.collection('gallery_kuih');

    addTempahanKuih(String userid, String galleryID, int quantity) async{
      String orderName;
      String imageUrl;

      DocumentSnapshot docSnap = await _galleryCollection.document(galleryID).get();
      orderName = docSnap.data['title'];
      imageUrl = docSnap.data['image_url'];

      await _bookingCollection.add({
        'order_name' : orderName,
        'quantity'   : quantity,
        'status'     : 'Booked',
        'user_id'    : userid,
        'image_url'  : imageUrl,
        'item_id'    : galleryID,

      });
    }

    updateTempahanStatus(String tempahanID, String status) async{
      await _bookingCollection.document(tempahanID).updateData({
        'status'     : status,
      });
      
    }

    getAllTempahanKuih() async{
      QuerySnapshot querySnapshot = await _bookingCollection.getDocuments();
      return querySnapshot.documents;
    }

    getTempahanKuih(String userId) async{
      QuerySnapshot querySnapshot = await _bookingCollection.where("user_id", isEqualTo: userId).getDocuments();
      for(int i=0 ; i<querySnapshot.documents.length; i++){
        
      print(querySnapshot.documents[i].documentID);
    }
      if(querySnapshot.documents == null )
      {
        print('in gettempahankuih');
      }
      return querySnapshot.documents;
    }
}