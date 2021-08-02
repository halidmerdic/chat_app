import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key, required this.chatRoomId}) : super(key: key);
  final String chatRoomId;
  // again I don't need
  // ConversationScreen(this.chatRoomId);
  // I have it in line 6

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();

  late Stream chatMessagesStream;

  Widget ChatMessageList(){

    return StreamBuilder<dynamic>(
      stream: chatMessagesStream,
        builder: (context, snapshot){
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
            return MessageTile(snapshot.data!.docs[index].data('message'), message: '',);
            });
    });

  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, String> messageMap = {
        'message' : messageController.text,
        'sendBy' : Constants.myName
      };

      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = '';
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
    child: appBarMain(BuildContext),
    ),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: const Color(0x54FFFFFF),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0,),
                child: Row(
                  children: [
                     Expanded(
                        child: TextField(
                          controller: messageController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Message...',
                            hintStyle: TextStyle(
                              color: Colors.white54,
                            ),
                            border: InputBorder.none,
                          ),
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        sendMessage();
                      },
                      child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0x36FFFFFF),
                                  Color(0x0FFFFFFF),
                                ]
                            ),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset('assets/images/send.png')

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile(data, {Key? key, required this.message}) : super(key: key);
  final String message;
  // I have a constructor in 2 lines above (this.message)

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('message', style: mediumTextStyle(),),
    );
  }
}

