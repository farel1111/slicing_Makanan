import 'package:flutter/material.dart';
import 'package:food_shop/pages/HomePage.dart';
import 'package:food_shop/widgets/BarBawah.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://iujrmlottuweyayvlxrv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1anJtbG90dHV3ZXlheXZseHJ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA5NjQ3MDEsImV4cCI6MjA0NjU0MDcwMX0.AwRJGCR7pP4ytupx7jUYLO_tDmEQjy2f54Veql-_tZk',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       scaffoldBackgroundColor:const Color.fromARGB(255, 255, 255, 255)
      ),
      routes:{
        '/': (context) =>  BarBawah()
      }
    );
  }
}
