import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/services/auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png',
          height: 50.0,
        ),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const Authenticate()
              ));
            },
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0,),
            child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
    );
  }
}
