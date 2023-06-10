import 'package:flutter/material.dart';
import 'package:movie_provider/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class FavMoviesList extends StatefulWidget {
  const FavMoviesList({Key? key}) : super(key: key);

  @override
  State<FavMoviesList> createState() => _FavMoviesListState();
}

class _FavMoviesListState extends State<FavMoviesList> {
  @override
  Widget build(BuildContext context) {
    final _myList = context.watch<MovieProvider>().myList;
    return Scaffold(
      appBar: AppBar(
        title: Text("My List (${_myList.length})"),
      ),
    body: ListView.builder(
    itemCount: _myList.length,
    itemBuilder: (_,index){
      final currentMovie = _myList[index];
      return Card(
    key:ValueKey(currentMovie.title),
    elevation: 4,
    child: ListTile(
    title: Text(currentMovie.title),
    subtitle: Text(currentMovie.duration ?? ''),
    trailing: TextButton(
    child: const Text(
    'Remove',
    style: TextStyle(color: Colors.red),
    ),
    onPressed: (){
      context.read<MovieProvider>().removeFromList(currentMovie);
    },
    ),
    ),
    );
    }

    ),
    );
  }
}
