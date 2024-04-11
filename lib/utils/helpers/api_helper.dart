import 'dart:convert';
import 'package:http/http.dart'as http;
class APIHelper{
  Future<String> translateData({required String text,required String source,required String target})
  async {
    var bodyJson={
      "text": text,
      "source": source,
      "target": target
    };
    Map<String,String>? header= {
      'content-type': 'application/json',
      'X-RapidAPI-Key': '090af0fcf9msh052e8d02c1d238dp1f0666jsn5ff1fc6b8758',
      'X-RapidAPI-Host': 'translate-plus.p.rapidapi.com'
    };
    var jsonData=jsonEncode(bodyJson);
    var result=await http.post(Uri.parse("https://translate-plus.p.rapidapi.com/translate"),body: jsonData,headers:header );
    if(result.statusCode==200)
      {
        var mainJson=await jsonDecode(utf8.decode(result.bodyBytes));
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
        var mainJson=await jsonDecode(result.body);
        Map lMap=mainJson["supported_languages"];
        return lMap;
      }
    return {};
  }
}
/* axios = require('axios');

const options = {
  method: 'GET',
  url: 'https://translate-plus.p.rapidapi.com/',
  headers:
};

try {
const response = await axios.request(options);
console.log(response.data);
} catch (error) {
console.error(error);
const axios = require('axios');

const options = {
  method: 'POST',
  url: 'https://translate-plus.p.rapidapi.com/translate',
  headers: {
    'content-type': 'application/json',
    'X-RapidAPI-Key': '090af0fcf9msh052e8d02c1d238dp1f0666jsn5ff1fc6b8758',
    'X-RapidAPI-Host': 'translate-plus.p.rapidapi.com'
  },
  data: {
    text: 'Hello , How are you',
    source: 'en',
    target: 'nl'
  }
};

try {
	const response = await axios.request(options);
	console.log(response.data);
} catch (error) {
	console.error(error);
}
}*/