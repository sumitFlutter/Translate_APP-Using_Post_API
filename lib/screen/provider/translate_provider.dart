import 'package:flutter/cupertino.dart';
import 'package:translate_api_app/utils/helpers/api_helper.dart';

class TranslateProvider with ChangeNotifier {
  String translate = "Enter You Wanna Translate: (in above TextField)";
  String source = "en",
      target = "gu",
      text = "",
      sourceLan = "English",
      targetLan = "Gujarati";
  APIHelper apiHelper = APIHelper();
  Map langModelList = {};

  void getSourceLan({required String lCode, required String lan}) {
    source = lCode;
    sourceLan = lan;
    notifyListeners();
  }

  void getTargetLan({required String lCode, required String lan}) {
    target = lCode;
    targetLan = lan;
    notifyListeners();
  }

  void processing() {
    translate = "Processing please wait few Seconds";
    notifyListeners();
  }

  Future<void> getTranslate({required String textTxt}) async {
    text = textTxt;
    String t = await apiHelper.translateData(
      source: source,
      target: target,
      text: text,
    );
    translate = t;
    notifyListeners();
  }

  void getLangData() async {
    if(await apiHelper.getLang()=={})
      {
        langModelList={};
      }
    else{
      Map  m1 = await apiHelper.getLang();
      langModelList=m1;
    }
    notifyListeners();
  }
}
