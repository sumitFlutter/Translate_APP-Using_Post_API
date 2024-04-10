import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translate_api_app/screen/provider/translate_provider.dart';
import 'package:translate_api_app/utils/routes/translate_routes.dart';
void main()
{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TranslateProvider())
      ],
      child: Consumer<TranslateProvider>(
        builder: (context, value, child) {
          value.getLangData();
          return
          MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: apiRoutes,
          );
        },
      ),
    ),
  );
}