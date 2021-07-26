import 'package:chat_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User user) {
    if (user != null) {
      return AppUser(userId: user.uid);
    } else {
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.
      signInWithEmailAndPassword(email: email, password: password);

      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.
      createUserWithEmailAndPassword(email: email, password: password);

      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
    }
  }

    Future resetPass(String email) async{

    try{

      return await _auth.sendPasswordResetEmail(email: email);

    }catch(e){
      print(e.toString());
    }

    }

    Future signOut() async {

    try{

      return await _auth.signOut();

    }catch(e){

    }
    }

}