import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/Screens/massagePage.dart';

import 'Screens/HomeScreen.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
       MaterialApp(

        routes: {
           '/':(context)=>HomeScreen(),
          '/massage':(context)=>MassageScreen(),
        }
         ,
         initialRoute: (credential.currentUser!=null)?'/massage':'/',
        // home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      )
  );
}