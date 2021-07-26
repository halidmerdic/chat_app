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

  late QuerySnapshot searchSnapshot;

  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text).then((val) {
      searchSnapshot = val;
    });
  }

  Widget SearchList(){
    return ListView.builder(
      itemCount: searchSnapshot.docs.length,
      itemBuilder: (context, index){
        return SearchTile(
            userName: searchSnapshot.docs[index].data['name'],
            userEmail: searchSnapshot.docs[index].data["email"],
        );
      }
    );
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
  SearchTile({ required this.userName,  required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(userName, style: simpleTextStyle(),),
              Text(userEmail, style: simpleTextStyle(),),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('Message'),
          ),
        ],
      ),
    );
  }
}

