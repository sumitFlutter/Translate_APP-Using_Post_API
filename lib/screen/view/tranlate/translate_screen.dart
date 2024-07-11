import 'package:flutter/material.dart';
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
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController textTxt = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLangDataMap();
  }

  @override
  Widget build(BuildContext context) {
    r = context.read<TranslateProvider>();
    w = context.watch<TranslateProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Translate Assistant",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(5),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(border: Border.all()),
          child: Center(
            child: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                              "please Select in Which Language you have Typed:"),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton.icon(onPressed: () {
                            getSource();
                          }, label: Text(w!.sourceLan),icon: Icon(Icons.arrow_drop_down_outlined),)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                              "please Select in Which Language you have to Translate:"),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton.icon(onPressed: () {
                            getTarget();
                          }, label: Text(w!.targetLan),icon: Icon(Icons.arrow_drop_down_outlined),)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: textTxt,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      hintText:
                          "Enter Speech or Sentence or word That you wanna translate here:",
                      prefixIcon: Icon(Icons.translate),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Field is required to translate";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            r!.processing();
                            r!.getTranslate(textTxt: textTxt.text);
                            textTxt.clear();
                          }
                        },
                        child: const Text("Translate")),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(width: 2)),
                    child: Center(
                      child: SelectableText(
                        w!.translate,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getSource() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Consumer<TranslateProvider>(
          builder: (context, setState,child) {
            return Container(
              width: MediaQuery.sizeOf(context).width,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Please Select Source Language:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                setState.langModelList==null
                    ? const Text("Check your network connection")
                    : Container(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  child: ListView.builder(
                    itemCount: setState.langModelList!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          r!.getSourceLan(
                              lCode: setState.langModelList![
                              setState.langModelList!.keys.toList()[index]],
                              lan: setState.langModelList!.keys.toList()[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(border: Border.all()),
                          child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(setState.langModelList!.keys.toList()[index]),
                                Visibility(visible: setState.langModelList!.keys.toList()[index] ==
                                    setState.sourceLan,child: Icon(Icons.check),)
                              ]),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          r!.getSourceLan(lCode: "en", lan: "English");
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK!"))
                  ],
                ),
              ]),
            );
          },
        );
      },
    );
  }

  void getTarget() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Consumer<TranslateProvider>(
          builder: (context, setState,child) =>  Container(
            width: MediaQuery.sizeOf(context).width,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please Select Target Language:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              setState.langModelList==null
                  ? const Text("Check your network connection")
                  : Container(
                      height: 200,
                      width: MediaQuery.sizeOf(context).width,
                      child: ListView.builder(
                        itemCount: setState.langModelList!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              r!.getTargetLan(
                                  lCode: setState.langModelList![
                                  setState.langModelList!.keys.toList()[index]],
                                  lan: setState.langModelList!.keys.toList()[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(border: Border.all()),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(setState.langModelList!.keys.toList()[index]),
                                    Visibility(visible: setState.langModelList!.keys.toList()[index] ==
                                        setState.targetLan,
                                    child: Icon(Icons.check),),
                                  ]),
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                    onPressed: () {
                      r!.getTargetLan(lCode: "gu", lan: "Gujarati");
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK!"))
              ])
            ]),
          ),
        );
      },
    );
  }
  void getLangDataMap()
  async {
    await context.read<TranslateProvider>().getLangData();
  }
}
