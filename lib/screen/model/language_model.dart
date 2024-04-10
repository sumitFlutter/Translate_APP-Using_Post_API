class LangModel{
  String? lang="",code="";

  LangModel({this.lang, this.code});
  factory LangModel.mapToModel(Map m1)
  {
    return LangModel(lang: m1["lang"],code: m1["1"]);
  }
}
// i did not used this model and lang.json