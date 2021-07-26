import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  QuerySnapshot? searchSnapshot;

  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text).then((val) {
      setState(() {
        searchSnapshot = val;
      });;
    });
  }

  /// create chatroom, send user to conversation screen, pushreplacement
  createChatroomAndStartConversation(String userName){

    List<String> users = [userName, ];

    // to see what I need to implement delete .createChatRoom()
    // something is missing in the ()
    databaseMethods.createChatRoom();
  }

  Widget SearchList(){
    return searchSnapshot != null ? ListView.builder(
      shrinkWrap: true,
      itemCount: searchSnapshot!.docs.length,
      itemBuilder: (context, index){
        return SearchTile(
            userName: searchSnapshot!.docs[index].get('name'),
            userEmail: searchSnapshot!.docs[index].get('email'),
        );
      }
    ) : Container();
  }

  @override
  void initState() {

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
        child: Column(
          children: [
            Container(
              color: const Color(0x54FFFFFF),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0,),
              child: Row(
                children: [
               Expanded(
                  child: TextField(
                    controller: searchTextEditingController,
                    style: const TextStyle(
                color: Colors.white,
              ),
                    decoration: const InputDecoration(
                      hintText: 'search username...',
                      hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                      border: InputBorder.none,
                    ),
                  )
              ),
              GestureDetector(
                onTap: (){
                  initiateSearch();
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
                    child: Image.asset('assets/images/search_white.png')

                ),
              ),
          ],
              ),
            ),
            SearchList(),
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  const SearchTile({Key? key, required this.userName, required this.userEmail}) : super(key: key);

  final String userName;
  final String userEmail;

  //already been there because it is newer version of Flutter
  // SearchTile({ required this.userName,  required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: mediumTextStyle(),),
              Text(userEmail, style: mediumTextStyle(),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text('Message', style: mediumTextStyle(),),
            ),
          ),
        ],
      ),
    );
  }
}

