class Cast {

  List<Actor> actores = List();

  Cast.fromJsonList(List<dynamic> jsonList){

     if(jsonList == null ) return ;

     jsonList.forEach((item) {
       final actor = Actor.jsonFromMap(item);
       actores.add(actor);
     });
    
  }

}


class Actor {
  bool adult;
  int gender;
  int id;
 /*  KnownForDepartment knownForDepartment; */
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    /* this.knownForDepartment, */
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  Actor.jsonFromMap(Map<String, dynamic> json ){
    adult         = json['adult'];
    gender        = json['gender'];
    id            = json['id'];
    name          = json['name'];
    originalName  = json['original_name'];
    popularity    = json['popularity'];
    profilePath   = json['profile_path'];
    castId        = json['cast_id'];
    character     = json['character'];
    creditId      = json['credit_id'];
    order         = json['order'];
    department    = json['department'];
    job           = json['job'];
  }

  String getPhoto(){

    if (profilePath == null) {
      return 'https://www.allianceplast.com/wp-content/uploads/2017/11/no-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }

  }

}


