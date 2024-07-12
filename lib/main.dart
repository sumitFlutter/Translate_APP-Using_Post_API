import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:translate_api_app/screen/provider/translate_provider.dart';
import 'package:translate_api_app/utils/routes/translate_routes.dart';
void main()
{WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(
    const MyApp(),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: TranslateProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: apiRoutes,
        )
    );
  }
}
