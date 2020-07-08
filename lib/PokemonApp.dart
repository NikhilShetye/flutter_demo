import 'package:flutter/material.dart';
import 'package:flutter_demo/models/pokemon.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_demo/pokedetail.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => {runApp(PokeApp())};

Future<List<Pokemon>> fetchPokemons(http.Client client) async {
  final response = await client.get(
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePokemons, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Pokemon> parsePokemons(String responseBody) {
  // final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  final parsed = jsonDecode(responseBody);
  print(parsed['pokemon']);
var pokemon;
  if (parsed['pokemon'] != null) {
    pokemon = new List<Pokemon>();
    parsed['pokemon'].forEach((v) {
      pokemon.add(new Pokemon.fromJson(v));
    });
  }

  return pokemon;
  // return parsed['pokemon'] as List<Pokemon>;

  // return parsed.map<Pokemon>((json) => Pokemon.fromJson(json)).toList();
}

class PokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Poke App",
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: PokeMonHomePage(),
    );
  }
}

class PokeMonHomePage extends StatefulWidget {
  @override
  _PokeMonHomePageState createState() => _PokeMonHomePageState();
}

class _PokeMonHomePageState extends State<PokeMonHomePage> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
        backgroundColor: Colors.cyan,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: null,
        child: Icon(Icons.refresh),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: fetchPokemons(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PokemonsList(pokemons: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PokemonsList extends StatelessWidget {
  final List<Pokemon> pokemons;

  PokemonsList({Key key, this.pokemons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PokeDetail(pokemon: pokemons[index],),)
          ),
                  child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Hero(
              tag: pokemons[index].img,
                          child: Card(
                elevation: 5.0,
              
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.network(pokemons[index].img),
                    Text(pokemons[index].name,
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
