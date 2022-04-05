import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_guia/model/guia_manager.dart';
import 'package:ride_guia/screens/login_page.dart';

Future main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => GuiaManager(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ride Guia',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: const LoginPage(),
        ),
    );
  }
}