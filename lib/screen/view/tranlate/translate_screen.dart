import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:translate_api_app/screen/provider/translate_provider.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  TranslateProvider? r;
  TranslateProvider? w;
  GlobalKey<FormState> key=GlobalKey<FormState>();
  TextEditingController textTxt=TextEditingController();
  @override
  Widget build(BuildContext context) {
    r=context.read<TranslateProvider>();
    w=context.watch<TranslateProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Translate Assistant",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      body: Container(padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(border: Border.all()),
        child: Center(child: Form(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Column(mainAxisSize: MainAxisSize.min,
                  children: [
                   Text("please Select in Which Language you have Typed:"),
                    SizedBox(height: 2,),
                    Row(mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(),
                        ),
                        child: Text(w!.sourceLan),
                      ),
                      IconButton(onPressed: () {
                        getSource();
                      }, icon: Icon(Icons.arrow_drop_down_outlined))
                    ],)
                  ],),
                  SizedBox(height: 10,),
                  Column(mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("please Select in Which Language you have to Translate:"),
                      SizedBox(height: 2,),
                      Row(mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(border: Border.all(),
                            ),
                            child: Text(w!.targetLan),
                          ),
                          IconButton(onPressed: () {
                            getTarget();
                          }, icon: Icon(Icons.arrow_drop_down_outlined))
                        ],)
                    ],)
                ],
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: textTxt,
                decoration:  InputDecoration(enabledBorder: OutlineInputBorder(),
                hintText: "Enter Speech or Sentence or word That you wanna translate here:",
                  prefixIcon: Icon(Icons.translate),
                ),
                validator: (value) {
                  if(value!.isEmpty)
                    {
                      return "This Field is required to translate";
                    }
                  else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 15,),
              Center(
                child: ElevatedButton(onPressed: () async {
                  if(key.currentState!.validate())
                    {
                      r!.processing();
                     await  r!.getTranslate(textTxt: textTxt.text);
                      textTxt.clear();
                    }
                }, child: const Text("Translate")),
              ),
              SizedBox(height: 25,),
              Container(
                decoration: BoxDecoration(border: Border.all(width: 2)),
                child: Center(child: SelectableText(w!.translate,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),)
            ],
          ),
        ),),
      ),
      ),
    );
  }
  void getSource()
  {
    showModalBottomSheet(context: context, builder: (context) {
      return Column(
          children:[ Text("Please Select source Language:",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          SizedBox(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: w!.langModelList.length,
              itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  r!.getSourceLan(lCode: w!.langModelList[index].code!, lan: w!.langModelList[index].lang!);
                },
                title: Text(w!.langModelList[index].lang!),
                trailing: w!.langModelList[index].lang==w!.sourceLan?const Icon(Icons.check):Container(),
              );
            },
            ),
          ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: () {
                r!.getSourceLan(lCode: "en", lan: "English");
                Navigator.pop(context);
              }, child: Text("Cancel")),
              SizedBox(width: 4,),
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("OK!"))

            ],)
          ]
        );
    },);
  }
  void getTarget()
  {
    showModalBottomSheet(context: context, builder: (context) {
      return Column(
          children: [
            Text("Please Select Target Language:",style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            SizedBox(
              height: 300,
              width: 300,
              child: ListView.builder(
               itemCount: w!.langModelList.length,
               itemBuilder: (context, index) {
                 return ListTile(
                   onTap: () {
                     r!.getTargetLan(lCode: w!.langModelList[index].code!, lan: w!.langModelList[index].lang!);
                   },
                   title: Text(w!.langModelList[index].lang!),
                   trailing: w!.langModelList[index].lang==w!.targetLan?const Icon(Icons.check):Container(),
                 );
               },
                            ),
            ),
            SizedBox(height: 15,),
            Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: () {
                r!.getTargetLan(lCode: "gu", lan: "Gujarati");
                Navigator.pop(context);
              }, child: Text("Cancel")),
              SizedBox(width: 4,),
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("OK!"))
            ],)
          ],
        );
    },);
  }
}
