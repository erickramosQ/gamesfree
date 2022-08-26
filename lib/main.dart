import 'package:flutter/material.dart';
import 'package:gamesfree/pages/ListAllGames.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/ListGames',
      routes: {
        // Cuando naveguemos hacia la ruta "/", crearemos el Widget FirstScreen
        //'/Principal': (context) => const Principal(), ejemplos
        '/ListGames': (context) => const ListAllGames(),
        //'/ListStore': (context) => const ListStore(), ejemplos
        // Cuando naveguemos hacia la ruta "/second", crearemos el Widget SecondScreen
        //'/nuevoProducto': (context) =>const NewProducto(),
      },
    );
  }
}
