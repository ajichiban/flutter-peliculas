import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas ;

  final Function siguientePagina;

  
  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = PageController(
          initialPage: 1,
          viewportFraction: 0.3
        );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size; 

    /* Cargar siguientes paginas de Populares */
    _pageController.addListener(() {
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i){
          return _cardSingle(context, peliculas[i]) ;
        },
        /* children: _cards(), */
      ),
    );
  }

  Widget _cardSingle(BuildContext context, Pelicula pelicula){

    pelicula.uniqueId = '${pelicula.id}-poster';

    final card =  Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterImg()),
                height: 135,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: (){
        Navigator.pushNamed(context, 'pelicula', arguments: pelicula);
      },
    );
  }
  
  List<Widget> _cards() {
    return peliculas.map((pelicula) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterImg()),
                height: 135,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );

    }).toList();
  }
  


}