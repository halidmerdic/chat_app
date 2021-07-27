import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

import 'chat_rooms_screen.dart';

class SignIn extends StatefulWidget with PreferredSizeWidget {
  const SignIn({Key? key, required this.toggle}) : super(key: key);

  final Function toggle;
  SignIn.fromSignIn(this.toggle, {Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();


}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool isLoading = false;
  QuerySnapshot? snapshotUserInfo;

  signIn(){
    if(formKey.currentState!.validate()){
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
    }
    setState(() {
      isLoading = true;
    });

    databaseMethods.getUserByUserEmail(emailTextEditingController.text)
    .then((val){
      snapshotUserInfo = val;
      HelperFunctions.getUserEmailSharedPreference(snapshotUserInfo!.docs[0].get('name'));
    });

    authMethods.signInWithEmailAndPassword(emailTextEditingController.text,
    passwordTextEditingController.text).then((val){
      if( val != null){
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => const ChatRoom()
        ));
      }

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 58.0,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          return val!.isEmpty || val.length < 2
                              ? 'Please provide valid username'
                              : null;
                        },
                        controller: emailTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration('email'),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val!.length > 6 ? null : 'Provide 6+ character password';
                        },
                        controller: passwordTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration('password'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('Forgot Password?', style: simpleTextStyle(),),
                  ),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff007EF4),
                          Color(0xff2A75BC)]
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text('Sign In', style: mediumTextStyle(),
                  ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Text('Sign In with Google', style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: mediumTextStyle(),),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0,),
                        child: const Text('Register now!', style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        decoration: TextDecoration.underline,
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
