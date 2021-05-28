import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class MovieDetail extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _createAppbar(pelicula),
          /* Esta seccion no sera sliver , asi que se usa sliverList */
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20.0,),
                _posterTitle(context, pelicula),
                SizedBox(height: 20.0,),
                _description(pelicula),
                SizedBox(height: 20.0,),
                _createActores(pelicula)
              ]
            )
          )
        ],
      ),
    );
  }

  

  Widget _createAppbar(Pelicula pelicula) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0)
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
          ),
          
      ),
    );

  }

  Widget _posterTitle(BuildContext context, Pelicula pelicula) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
                
              ),
            ),
          ),
          SizedBox(width: 20.0,),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title, 
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis, 
                ), 
                Text(
                  pelicula.originalTitle, 
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis, 
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(), 
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );

  }

  Widget _description(Pelicula pelicula) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0 , vertical: 15.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      )
    );
  }

  Widget _createActores(Pelicula pelicula){

    final peliculaProvider = PeliculasProvider();

    return FutureBuilder(
      future: peliculaProvider.getCast(pelicula.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.hasData) {
          return _createCastingActhorsPage(snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator(),);
        }

      },
    );

  }

  Widget _createCastingActhorsPage(List<Actor> actores){

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        itemCount: actores.length,
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemBuilder: (context, i)=> _acthorCard(actores[i])
        
      ),
    );

  }

  Widget _acthorCard(Actor actor){

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getPhoto()),
              height: 150.0,
              fit: BoxFit.cover
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }





}