import 'dart:math';

class Peliculas {

  List<Pelicula> items = List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList){

    if (jsonList == null ) return;

    for (var item  in jsonList) {
      final pelicula = Pelicula.fromJsonMap(item);

      items.add(pelicula);
    }

  }


}


class Pelicula{
  String uniqueId;
  String title;
  String releaseDate;
  bool adult;
  String backdropPath;
  double popularity;
  List<int> genreIds;
  String overview;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  int voteCount;
  bool video;
  double voteAverage;
  int id;

  Pelicula({
    this.title,
    this.releaseDate,
    this.adult,
    this.backdropPath,
    this.popularity,
    this.genreIds,
    this.overview,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.voteCount,
    this.video,
    this.voteAverage,
    this.id,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json){

    title              =  json['title'];
    releaseDate        =  json['release_date'];
    adult              =  json['adult'];
    backdropPath       =  json['backdrop_path'];
    popularity         =  json['popularity'] / 1 ;
    genreIds           =  json['genre_ids'].cast<int>();
    overview           =  json['overview'];
    originalLanguage   =  json['original_language'];
    originalTitle      =  json['original_title'];
    posterPath         =  json['poster_path'];
    voteCount          =  json['vote_count'];
    video              =  json['video'];
    voteAverage        =  json['vote_average'] / 1 ;
    id                 =  json['id'];
  }

  String getPosterImg(){

    if (posterPath == null) {
      return 'https://www.allianceplast.com/wp-content/uploads/2017/11/no-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }

  }

  String getBackgroundImg(){

    if (backdropPath == null) {
      return 'https://www.allianceplast.com/wp-content/uploads/2017/11/no-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }

  }


}

