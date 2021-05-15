import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection('users').add(userMap);
  }

  getUserByUsername(String username) async {
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('userName', isEqualTo: username)
        .get();

    return result;
  }

  getUserByUserEmail(String email) async {
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('userEmail', isEqualTo: email)
        .get();

    return result;
  }

  createChatRoom(String chatroomId, chatroomMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatroomId)
        .set(chatroomMap)
        .catchError((e) {
      print('--------------------------' + e);
    });
  }

  addConversationMessages(String chatroomId, messageMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatroomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print('--------------------------' + e);
    });
  }

  getConversationMessages(String chatroomId) async {
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatroomId)
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
  }

  getChatRoom(String userName) async{
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .where('users', arrayContains: userName)
        .snapshots();
  }
}
