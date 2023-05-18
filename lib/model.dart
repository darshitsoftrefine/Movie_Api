class MovieModel {
  final List<Search>? search;
  final String? totalResults;
  final String? response;

  MovieModel({required this.search,required this.totalResults,required this.response});
  
  
  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      MovieModel(
      search: json['Search'] == null
          ? []
          : (json['Search'] as List<dynamic>)
              .map((e) => Search.fromJson(e))
              .toList(),
      totalResults: json['totalResults'] as String? ?? '',
      response: json['Response'] as String? ?? '');

}

class Search {
  final String? title;
  final String? year;
  final String? imdbID;
  final String? type;
  final String? poster;

  Search({required this.title, required this.year, required this.imdbID, required this.type, required this.poster});

  factory Search.fromJson(Map<String, dynamic> json) =>
      Search(title: json['Title'] as String? ?? '',
          year: json['Year'] as String? ?? '',
          imdbID: json['imdbID'] as String? ?? '',
          type: json['Type'] as String? ?? '',
          poster: json['Poster'] as String? ?? '');


}

 // class Movie{
 //   Future<List<Search>> getUser() async{
 //     final response = await http.get(Uri.parse("https://www.omdbapi.com/?s=Batman&page=2&apikey=564727fa"));
 //     if(response.statusCode == 200){
 //       final data = jsonDecode(response.body);
 //       final List<Search> list1 = [];
 //       for(var i = 0; i < data['Search'].length; i++){
 //         final entry = data['Search'][i];
 //         list1.add(Search.fromJson(entry));
 //         print("List1 $list1");
 //       }
 //       return list1;
 //     } else {
 //       throw Exception('Http Failed');
 //     }
 //   }
 // }