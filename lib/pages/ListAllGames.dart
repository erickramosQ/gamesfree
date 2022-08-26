// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gamesfree/models/classJuegos.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ListAllGames());
}

class ListAllGames extends StatefulWidget {
  const ListAllGames({Key? key}) : super(key: key);

  @override
  State<ListAllGames> createState() => _ListAllGames();
}

class _ListAllGames extends State<ListAllGames> {
  List<JuegosApi> Agames = [];
  List<JuegosApi> Agamesfilter = [];
  var url = 'https://www.freetogame.com/api/games';

  @override
  void initState() {
    //al iniciar la aplicacion invocamos al metodo get para obtener los datos de la API
    metodoGet();
    Agamesfilter = Agames;
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: colorCustom, scaffoldBackgroundColor: colorCustom2),
      home: Scaffold(
          appBar: AppBar(title: const Text('All Games Free')),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  cursorRadius: Radius.circular(15),
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    labelText: 'Search game by name',
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Color.fromARGB(255, 49, 1, 3),
                    filled: true,
                  ),
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      Agamesfilter = Agames.where((games) {
                        var titulo = games.title.toLowerCase();
                        return titulo.contains(text);
                      }).toList();
                    });
                  },
                ),
              ),
              Expanded(
                child: Agamesfilter.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : verLista(context),
              ),
            ],
          )),
    );
  }

  Widget verLista(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: Agamesfilter.length,
        itemBuilder: (BuildContext context, int index) {
          return FadeInLeft(
            duration: Duration(milliseconds: 500),
            child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color.fromARGB(255, 49, 1, 3),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      // ignore: deprecated_member_use
                      launch(Agamesfilter[index].gameUrl);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            textAlign: TextAlign.end,
                            Agamesfilter[index].title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            Agamesfilter[index].developer,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            Agamesfilter[index].releaseDate,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 90.0)),
                          Text(
                            Agamesfilter[index].platform,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 5),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 220,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          Agamesfilter[index].thumbnail),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                Agamesfilter[index].shortDescription,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    Agamesfilter[index].publisher,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.0)),
                                  Container(
                                    width: 60,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: colorCustom,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Center(
                                      child: Text(
                                        'Push',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }

  //metodo para obtener todos los juegos disponibles de la API
  metodoGet() async {
    Response response = await get(Uri.parse(url));
    List<dynamic> data = jsonDecode(response.body);
    //Map<String, dynamic> map = jsonDecode(response.body);
    //List<dynamic> data = map["results"] ?? [];
    // ignore: avoid_print
    print(data);
    for (var dato in data) {
      Agames.add(JuegosApi(
        dato['id'],
        dato["title"],
        dato['thumbnail'],
        dato['short_description'],
        dato['game_url'],
        dato['genre'],
        dato['platform'],
        dato['publisher'],
        dato['developer'],
        dato['release_date'],
        dato['freetogame_profile_url'],
      ));
    }
    setState(() {});
  }

  metodoPost() async {
    Response response = await post(Uri.parse(url), body: {
      //Escribir codigo en formato Json para enviar
    });
    Map data = jsonDecode(response.body);
    //print(data);
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor colorCustom = MaterialColor(0xFAAA1529, color);
MaterialColor colorCustom2 = MaterialColor(0xFF410912, color);
