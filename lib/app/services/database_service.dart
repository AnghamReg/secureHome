
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;

  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');


  //Create and Update UserApp entity
  Future updateUserData(String pseudo, String email) async {
    return await userCollection.doc(uid).set({
      'pseudo': pseudo,
      'email': email
    });
  }

  Future<String> getUserPseudo() async {
    DocumentSnapshot userDoc = await userCollection.doc(uid).get();
    String pseudo;
    if (userDoc.exists) {
      // Cast data to Map<String, dynamic> before accessing the "pseudo" field
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      print("user data is : $userData");

      if (userData != null && userData.containsKey('pseudo')) {
        String fetchedPseudo = userData['pseudo'] ?? '';
        pseudo = fetchedPseudo;
      } else {
        pseudo = ''; // "pse
        // udo" field not found or null
      }
    } else {
      pseudo = ''; // "pseudo" field not found or null
    }
 return pseudo;
  }

  Future<String> getUserEmail() async {
    DocumentSnapshot userDoc = await userCollection.doc(uid).get();
    String email;
    if (userDoc.exists) {
      // Cast data to Map<String, dynamic> before accessing the "pseudo" field
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      print("user data is : $userData");

      if (userData != null && userData.containsKey('email')) {
        String fetchedEmail = userData['email'] ?? '';
        email = fetchedEmail;
      } else {
        email = ''; // "pse
        // udo" field not found or null
      }
    } else {
      email = ''; // "pseudo" field not found or null
    }

    return email;
  }
}