import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:utube_chatapp/views/signup.dart';

import 'helper/authenticate.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // bool userIsLoggedIn;

  // @override
  // void initState() {
  //   getLoggedInState();
  //   super.initState();
  // }

  // getLoggedInState() async {
  //   await HelperFunctions.getUserLoggedInSharedPreference().then((value){
  //     setState(() {
  //       userIsLoggedIn  = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        accentColor: Color(0xff007EF4),
        fontFamily: "OverpassRegular",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      Authenticate()
      //  userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : Authenticate()
      //     : Container(
      //   child: Center(
      //     child: Authenticate(),
      //   ),
      // ),
    );
  }
}
