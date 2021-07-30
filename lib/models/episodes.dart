import 'dart:convert';
import 'package:http/http.dart' as http;
import '../links.dart';

class Episodes {
  late List<Results> results;

  Episodes(this.results);

  Episodes.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Results {
  late String name;
  late String airDate;
  late String episode;

  Results(this.name, this.airDate, this.episode);

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    airDate = json['air_date'];
    episode = json['episode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['air_date'] = this.airDate;
    data['episode'] = this.episode;
    return data;
  }
}

Future<Episodes> getEpisodesFromAPI() async {
  var url = Uri.https(Links.authority, Links.unencodedPathEpisode);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    return Episodes.fromJson(json.decode(response.body));
  } else {
    throw Exception("Error response");
  }
}
