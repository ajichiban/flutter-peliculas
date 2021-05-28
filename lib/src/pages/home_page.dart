import 'package:flutter/material.dart';
import 'package:peliculas/src/custom_widgets/custom_card_swiper_widget.dart';
import 'package:peliculas/src/custom_widgets/movie_horizontal.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';



class HomePage extends StatelessWidget {

  final peliculasProvider = PeliculasProvider();


  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {
              showSearch(
                context: context, 
                delegate: DataSearch()
              )
            }
          )
        ],
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperCard(),
            _footer(context),
          ],
        ),
      )
    );
  }

  Widget _swiperCard() {
   
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot ){
        if (snapshot.hasData) {
          return  CustomCardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )     
          );
        }
      },
      
    );
  
  }

  Widget _footer(BuildContext context){
    

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(height: 5.0,),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              
              if (snapshot.hasData) {
                return MovieHorizontal(
                      peliculas: snapshot.data,
                      siguientePagina: peliculasProvider.getPopulares,
                    );
              }else{
                return  Center(
                  child: CircularProgressIndicator()
                );
              }
              
            },
          ),
        ],
      ),
    );

  }





}/* Final */