import 'package:get/get.dart';
import 'package:myp/app/services/database_realtime_service.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechController extends GetxController {
  static Rx<SpeechToText> speechToText = SpeechToText().obs;
  Rx<bool> speechEnabled = false.obs;
  Rx<String> lastWords = ''.obs;
  Rx<bool> isListeningMessage = false.obs, isListeningMic = false.obs;
  List keyWordsLightFr = [
    "allumez allumer allume lumière",
    "fermez ferme fermer lumière"
  ];
  Rx<String> returnMessage = "".obs;
  Rx<String> uid = "".obs;
  Rx<bool> lightIsOn = false.obs;
  DatabaseRealtimeService databaseRealtimeService = DatabaseRealtimeService();

  @override
  void onInit() {
    super.onInit();
    String uidTry = Get.arguments["uid"];
    if (uidTry != null) {
      uid.value = uidTry;
      print("uid : ${uid.value} ");
    }
  }

  Future _changeLight() async {
    await databaseRealtimeService.changeLightWithValue(
        uid.value, lightIsOn.value);
  }

  void initSpeech() async {
    speechToText = SpeechToText().obs;
    speechEnabled.value = (await speechToText?.value.initialize())!;
  }

  void stopListening() async {
    await speechToText?.value.stop();
  }

  void startListening() async {
    isListeningMic.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      isListeningMessage.value = true;
    });
    await speechToText?.value.listen(onResult: _onSpeechResult);
  }

  void _answerRecognizedWords(String spokenPhrase) {
    List<String> keywordWords = spokenPhrase.toLowerCase().split(' ');
    int max = 0;
    int maxIndex = -1; // Initialize with an invalid index
    for (int i = 0; i < keyWordsLightFr.length; i++) {
      int cpt = 0; // Reset the counter for each keyword set
      for (String word in keywordWords) {
        if (keyWordsLightFr[i].contains(word)) {
          cpt++;
        }
      }
      if (cpt > max) {
        max = cpt;
        maxIndex = i;
      }
    }
    switch (maxIndex) {
      case 0:
        lightIsOn.value = true;
        _changeLight();
        returnMessage = "your light is turned on".obs;
        break;
      case 1:
        lightIsOn.value = false;
        _changeLight();
        returnMessage = "your light is turned off".obs;
        break;
      default:
        returnMessage = "i didn't understand what you said".obs;
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    lastWords.value = result.recognizedWords;
    isListeningMic.value = false;
    Future.delayed(const Duration(seconds: 7), () {
      isListeningMessage.value = false;
    });
    print("speech = ${speechToText?.value.lastRecognizedWords}");
    _answerRecognizedWords(speechToText!.value.lastRecognizedWords);
    print("return msg = $returnMessage");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    Get.back();
  }
}
