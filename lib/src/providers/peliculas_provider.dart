import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actor_model.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apiKey = '539b1ed43e74905904c8bc21df2fa7ec';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _peliculasPage = 0;

  bool cargando = false;

  /* Implementadon los stream */
  List<Pelicula> _peliculasPopulares = List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStream(){
    _popularesStreamController?.close();
  }



  Future<List<Pelicula>> _prepararRespuesta(Uri url) async {

    final res = await http.get(url);

    final decodedData = json.decode(res.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language': _language
    });

    return await _prepararRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {

    if(cargando) return [];

    cargando = true;

    _peliculasPage ++;
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apiKey,
      'language': _language,
      'page' : _peliculasPage.toString(),
    });

    final res =  await _prepararRespuesta(url);

    _peliculasPopulares.addAll(res);

    popularesSink(_peliculasPopulares);

    cargando = false;

    return res;

  }

  Future<List<Actor>> getCast(peliculaId) async {

    final url = Uri.https(_url, '3/movie/$peliculaId/credits', {
      'api_key' : _apiKey,
      'language': _language
    });

    final res = await http.get(url);

    final decodedData = json.decode(res.body);

    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.actores;

  }

  Future<List<Pelicula>> searchMovie(String query) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _apiKey,
      'language': _language,
      'query'   : query
    });

    return await _prepararRespuesta(url);

  }


}