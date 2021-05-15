import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:utube_chatapp/helper/constants.dart';
import 'package:utube_chatapp/services/database.dart';
import 'package:utube_chatapp/widgets/app_bar_widget.dart';

import 'conversation_screen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DataBaseMethods databaseMethods = new DataBaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  sendMessage({String userName}) {
    if (userName != Constants.myName) {
      String chatroomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatroomMap = {
        'users': users,
        'chatroomId': chatroomId
      };
       
      DataBaseMethods().createChatRoom(chatroomId, chatroomMap);
 
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Chat(  chatRoomId: chatroomId,)
                
                  ));
    } else {
      print('u cant send message to urself');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget userTile(String userName, String userEmail) {
    //searchTile
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              sendMessage(userName: userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Message",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: Color(0x54FFFFFF),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchEditingController,
                            style: simpleTextStyle(),
                            decoration: InputDecoration(
                                hintText: "search username ...",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            initiateSearch();
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0x36FFFFFF),
                                        const Color(0x0FFFFFFF)
                                      ],
                                      begin: FractionalOffset.topLeft,
                                      end: FractionalOffset.bottomRight),
                                  borderRadius: BorderRadius.circular(40)),
                              padding: EdgeInsets.all(12),
                              child: Image.asset(
                                "assets/images/search_white.png",
                                height: 25,
                                width: 25,
                              )),
                        )
                      ],
                    ),
                  ),
                  userList()
                ],
              ),
            ),
    );
  }

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      await databaseMethods
          .getUserByUsername(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.docs.length,
            itemBuilder: (context, index) {
              return userTile(
                searchResultSnapshot.docs[index]["userName"],
                searchResultSnapshot.docs[index]["userEmail"],
              );
            })
        : Container();
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
