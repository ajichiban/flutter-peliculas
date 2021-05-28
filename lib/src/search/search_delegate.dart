import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  final peliculas = [
    'deadpool',
    'wolverine',
    'xmen',
    'ironman ',
    'ironman 2',
    'ironman 3',
    'superman',
    'batman',
    'Avenger'
  ];

  final peliculasRecientes = [
    'avenger ',
    'spiderman'
  ];

  final peliculasProvider = PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
      // Las acciones de nuestro appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation
      ), 
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Los resultados que arrojara la busqueda
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // las sugerencias que apareceran cuando el usuario escriba.

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if(snapshot.hasData){
           
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((pelicula) {
              
              pelicula.uniqueId = '${pelicula.id}-search';

              return ListTile(
                leading: Hero(
                  tag: pelicula.uniqueId,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'), 
                    image: NetworkImage(pelicula.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.cover,
                    ),
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  Navigator.pushNamed(context, 'pelicula', arguments: pelicula);
                },

              );

            }).toList(),
          );
        }else{
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.0,),
              Center(child: CircularProgressIndicator()),
            ],
          );
        }

      },
    );




    // materail de ejemplo
    /* final suggesList = query.isEmpty 
                        ? peliculasRecientes
                        : peliculas.where((p) => p.toLowerCase().startsWith(query) ).toList();

    return ListView.builder(
      itemCount: suggesList.length ,
      itemBuilder: (context, i){

         return ListTile(
           leading: Icon(Icons.movie),
           title: Text(suggesList[i]),
         );

      }
      
    ); */
  }


}