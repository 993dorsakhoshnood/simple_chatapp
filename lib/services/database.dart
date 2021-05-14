import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap);
  }

  getUserByUsername(String username) async {
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: username)
        .get();
    result.docs.forEach((res) {
      print('=======' + res.data().toString());
      
      return res.data() ;
    });
  }
}

//  .snapshots()
//         .listen((data) => data.docs[0]['name'])
