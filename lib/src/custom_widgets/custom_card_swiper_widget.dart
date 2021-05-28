import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CustomCardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CustomCardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 20.0),
     
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5 ,
        itemBuilder: (BuildContext context,int index){
          
          peliculas[index].uniqueId = '${peliculas[index].id}-card';

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'pelicula', arguments: peliculas[index]);
                },
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  fit: BoxFit.cover,
                ),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          );
        },
        layout: SwiperLayout.STACK ,
        itemCount: peliculas.length,
        /* pagination: SwiperPagination(),
        control: SwiperControl(), */
      ),
    );
  }






}