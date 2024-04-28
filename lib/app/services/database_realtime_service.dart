import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseRealtimeService{
  final rtdb = FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://smarthome-f314e-default-rtdb.firebaseio.com/');

  //old one
  Future<void> createUser(String uid, String email, String pseudo) async {
    rtdb.ref("users/$uid").set({
      "pseudo": pseudo,
      "cmd": {
        "lightIsOn": false, // par défaut
      },
      "view": {
        "temp": 10, // par défaut
        "hum": 60, //par défaut
        "gaz": 3305,
        "percentGarbage": 30
      }
    });
  }

  //new one
  Stream<Map<String, dynamic>> getUserDataRealtime(String uid) {
    // Reference to the user's data in the database
    DatabaseReference userRef = rtdb.ref("users/$uid");

    // Returning a stream that listens to changes
    return userRef.onValue.map((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        // Convert the data into a Map<dynamic, dynamic> and then cast to Map<String, dynamic>
        var rawData = event.snapshot.value as Map<dynamic, dynamic>;
        var userData = <String, dynamic>{
          'pseudo': rawData['pseudo']?.toString() ?? '',
          'temp': rawData['view']?['temp']?.toDouble() ?? 0.0,
          'hum': rawData['view']?['hum'] as int ?? 0,
          'percentGarbage': rawData['view']?['percentGarbage']?.toDouble() ?? 0.0,
          'lightIsOn': rawData['cmd']?['lightIsOn'] as bool ?? false,
          'gaz': rawData['view']?['gaz'] as int ?? 0,
        };
        return userData;
      } else {
        // Handle the case where there is no data
        return <String, dynamic>{};
      }
    });
  }


  /* old get method of info*/
  Future<Map<String, dynamic>> getUserDataNew(String uid) async {
    var snapshot = await rtdb.ref("users/$uid").once();
    if (snapshot.snapshot.value != null) {
      var rawData = snapshot.snapshot.value as Map<dynamic, dynamic>;
      var userData = <String, dynamic>{
        'pseudo': rawData['pseudo']?.toString() ?? '',
      };
      return userData;
    } else {
      throw Exception('User data not found in the database.');
    }
  }



  Future<String> getUserPseudo(String uid) async {
    var snapshot = await rtdb.ref("users/$uid/cmd/lightIsOn").once();
    if (snapshot.snapshot.value != null) {
      return snapshot.snapshot.value.toString();
    } else {
      throw Exception('User pseudo not found in the database.');
    }
  }

  Future<void> changeLight(String uid) async {
    bool lightIsOn=false;
    var snapshot= await rtdb.ref("users/$uid/cmd/lightIsOn").once();
    if (snapshot.snapshot.value != null) {
      lightIsOn= snapshot.snapshot.value as bool;
    } else {
      throw Exception('User lightIsOn not found in the database.');
    }
    DatabaseReference dr = await rtdb.ref("users/$uid/cmd");
    await dr.update(
      {
          "lightIsOn":!lightIsOn

      }
    );

  }

  Future<void> changeLightWithValue(String uid,bool value) async {

    DatabaseReference dr = rtdb.ref("users/$uid/cmd");
    await dr.update(
        {
          "lightIsOn":value
        }
    );

  }




}