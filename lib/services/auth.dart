import 'package:firebase_auth/firebase_auth.dart';
import 'package:macro_counter_app/models/User.dart';
import 'package:macro_counter_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase object
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? new User(user.uid, user.email) : null;
  }

  // auth change user steam
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future<User> getUser() async {
    FirebaseUser fireBaseUser = await _auth.currentUser();
    return new User(fireBaseUser.uid, fireBaseUser.email);
  }

  // sign anonymous
  Future signInAnon() async {
    print('Signing in anonymously...');
    try {
      AuthResult res = await _auth.signInAnonymously();
      FirebaseUser user = res.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // signin with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      print('Signing in...');
      AuthResult res = await _auth.signInWithEmailAndPassword(
          password: password, email: email);
      FirebaseUser user = res.user;
      print('done signing in...');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    print('Signing up user');
    try {
      AuthResult res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = res.user;

      // create new document for this user with uid
      await DatabaseService(uid: user.uid)
          .updateUserData(targetCarbs: 300, targetProtein: 130, targetFat: 100);
      print('done signup...');
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
