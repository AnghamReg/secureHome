import 'package:firebase_auth/firebase_auth.dart';
import 'package:myp/app/entities/user_data.dart';
import 'package:myp/app/services/database_realtime_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserApp? _userFromFireBaseUser(User? user) {
    return user != null ? UserApp(uid: user.uid) : null;
  }

  Stream<UserApp?> get user {
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String email, String password, String pseudo) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      await DatabaseRealtimeService().createUser(user!.uid, email, pseudo);

      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('ERROR ${e.toString()}');
      return null;
    }
  }
}
