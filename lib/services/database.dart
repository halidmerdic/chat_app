import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  getUserByUsername(String username) async {

    return await FirebaseFirestore.instance.collection('users')
        .where('name', isEqualTo: username)
        .get();

  }

  getUserByUserEmail(String userEmail) async {

    return await FirebaseFirestore.instance.collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection('users')
        .add(userMap).catchError((e){
          print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection('ChatRoom')
        .doc(chatRoomId).set(chatRoomMap).catchError((e){
          print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId)  {
    // I had async in a line above
    // I didn't have the return keyword in the line below
     return FirebaseFirestore.instance.collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
         .orderBy('time', descending: false)
        .get().then((value) => value.docs).asStream();
  }

  addConversationMessages(String chatRoomId, messageMap){
      return FirebaseFirestore.instance.collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap).catchError((e){print(e.toString());});
  }

}