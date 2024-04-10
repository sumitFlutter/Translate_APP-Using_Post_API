import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:translate_api_app/screen/model/language_model.dart';
class APIHelper{
  Future<String> translateData({required String text,required String source,required String target})
  async {
    var bodyJson={
      "text": text,
      "source": source,
      "target": target
    };
    var jsonData=jsonEncode(bodyJson);
    var result=await http.post(Uri.parse("https://translate-plus.p.rapidapi.com/translate"),body: jsonData,headers: {"X-RapidAPI-Key":"090af0fcf9msh052e8d02c1d238dp1f0666jsn5ff1fc6b8758","X-RapidAPI-Host": "translate-plus.p.rapidapi.com","content-type": "application/json"});
    if(result.statusCode==200)
      {
        var mainJson=jsonDecode(utf8.decode(result.bodyBytes));
        String ans=mainJson["translations"]["translation"];
        return ans;
      }
    return "Translation Got Error Please Try Again";
  }
  Future<Map> getLang()
  async {
    var result=await http.get(Uri.parse("https://translate-plus.p.rapidapi.com/"),headers: {
      'X-RapidAPI-Key': '090af0fcf9msh052e8d02c1d238dp1f0666jsn5ff1fc6b8758',
      'X-RapidAPI-Host': 'translate-plus.p.rapidapi.com',
    });
    if(result.statusCode==200)
      {
        var mainJson=jsonDecode(result.body);
        Map lMap=mainJson["supported_languages"];
        return lMap;
      }
    return {};
  }
}