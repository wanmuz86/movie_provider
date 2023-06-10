import 'package:flutter/material.dart';
import 'package:movie_provider/providers/movie_provider.dart';
import 'package:movie_provider/screens/fav_movies.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var movies = context.watch<MovieProvider>().movies;
    var myList = context.watch<MovieProvider>().myList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FavMoviesList()));
              },
              icon: const Icon(Icons.favorite),
              label: Text(
                "Go to my list (${myList.length})",
                style: const TextStyle(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 20)),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (_, index) {
                      final currentMovie = movies[index];
                      return Card(
                        key: ValueKey(currentMovie.title),
                        color: Colors.blue,
                        elevation: 4,
                        child: ListTile(
                          title: Text(
                            currentMovie.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            currentMovie.duration ?? 'No information',
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: myList.contains(currentMovie)
                                  ? Colors.red
                                  : Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              if (!myList.contains(currentMovie)) {
                                context
                                    .read<MovieProvider>()
                                    .addToList(currentMovie);
                              } else {
                                context
                                    .read<MovieProvider>()
                                    .removeFromList(currentMovie);
                              }
                            },
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
