import 'package:flutter/material.dart';
import 'package:kursus/screen/registerform.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kursus/firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(page_home());
}

class page_home extends StatelessWidget {
  const page_home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registerform(),
    );
  }
}