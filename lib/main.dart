import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlivequery/core/parse/parse_provider.dart';
import 'package:flutterlivequery/views/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ParseProvider.i.initParse();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.dark),
      home: LoginScreen(),
    );
  }
}
