import 'package:firebase_auth/firebase_auth.dart';
import 'package:macro_counter_app/models/User.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase object
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? new User(user.uid) : null;
  }

  // auth change user steam
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign anonymous
  Future signInAnon() async {
    print('Signing in anonymously...');
    try {
      AuthResult res = await _auth.signInAnonymously();
      FirebaseUser user = res.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signin with email and password
  Future signInWithEmailAndPassword (String email, String password) async {
    try {
      AuthResult res = await _auth.signInWithEmailAndPassword(password: password, email: email);
      FirebaseUser user = res.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = res.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  // sign out
  Future signOut() async {
    try {
      print('signing out...');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
