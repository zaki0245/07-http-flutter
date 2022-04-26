import 'package:flutter/material.dart';
import 'package:http_req/service/http_service.dart';
import 'movie_detail.dart';

// import 'movie_detail.dart';
class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late int moviesCount;
  late List movies;
  late HttpService service;
  bool _isLoading = true;

  Future initialize() async {
    service.getPopularMovies().then((value) => {
          setState(() {
            movies = value!;
            moviesCount = movies.length;
            _isLoading = false;
          })
        });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies | Muhammad Zaki 2031710106"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: (moviesCount == null) ? 0 : moviesCount,
              itemBuilder: (context, int position) {
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    leading: SizedBox(
                      height: 100,
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500/" +
                            movies[position].posterPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(movies[position].title),
                    subtitle: Text(
                        'Rating =' + movies[position].voteAverage.toString()),
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => MovieDetail(movies[position]));
                      Navigator.push(context, route);
                    },
                  ),
                );
              },
            ),
    );
  }
}
