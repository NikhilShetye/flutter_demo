import 'package:flutter/material.dart';
import 'package:flutter_demo/models/pokemon.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height/1.5,
            width: MediaQuery.of(context).size.width-20,
            left: 10.0,
            top: MediaQuery.of(context).size.height*0.1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)
                        ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 100.0,
                  ),
                  Text(pokemon.name, style: TextStyle(
                    fontSize: 25.0,fontWeight: FontWeight.bold
                  ),),
                  Text("Height : ${pokemon.height}"),
                  Text("Weight ${pokemon.weight}"),
                  Text("Types",style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((e) => FilterChip(
                          backgroundColor: Colors.amber,
                              label: Text(e),
                              onSelected: (value) => {},
                            ))
                        .toList(),
                  ),
                  Text("Weaknesses",style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((e) => FilterChip(

                          backgroundColor: Colors.red,
                              label: Text(e,
                              style: TextStyle(color: Colors.white),),
                              onSelected: (value) => {},
                            ))
                        .toList(),
                  ),
                  Text("Next Evolution",style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.nextEvolution
                        .map((n) => FilterChip(
                          backgroundColor: Colors.green,

                              label: Text(n.name.toString(),
                              style: TextStyle(color: Colors.white),),
                              onSelected: (value) => {},
                            ))
                        .toList(),
                  ),
                  // Text("Multipliers"),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: pokemon.multipliers
                  //       .map((e) => FilterChip(
                  //             label: Text(e.toString()),
                                                            
                  //             onSelected: (value) => {},
                  //           ))
                  //       .toList(),
                  // )
                ],
              ),
            ),
          ),
          Align(alignment: Alignment.topCenter,
          child: Hero(tag: pokemon.img, child: 
          Container(
           height: 200.0,
           width: 200.0,
           decoration: BoxDecoration(
             
             image: DecorationImage(
               fit: BoxFit.cover,
               image: NetworkImage(pokemon.img))
           ),
          )),)
        ],
      );

  PokeDetail({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(pokemon.name),
      ),
      body: bodyWidget(context),
    );
  }
}
