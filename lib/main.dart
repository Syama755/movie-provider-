import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/screen/wishlist.dart';

import '../provider/movieprovider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<MovieProvider>(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        home: Homee(),
      ),
    ),
  );
}

class Homee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var movie_to_wishlist = context.watch<MovieProvider>().wishmovie; // empty list from provider
    var movies = context.watch<MovieProvider>().movies;  // movie list from provider

    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              ElevatedButton.icon(        ///named constructor
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WishList()));
                  },
                  icon: Icon(Icons.favorite),
                  label: Text("WishList ${movie_to_wishlist.length}")),
              Expanded(
                  child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        // movies is a list of map
                        final currentmovie = movies[index];
                        return Card(
                          child: ListTile(
                            title: Text(currentmovie.title),
                            subtitle: Text(currentmovie.time), // No null-aware operator needed here
                            trailing: IconButton(
                                onPressed: () {
                                  if (!movie_to_wishlist.contains(currentmovie)) {
                                    /// movie add to wishlist and update favorite icon color
                                    context.read<MovieProvider>().addToList(currentmovie);
                                  } else {
                                    context.read<MovieProvider>().removeFromList(currentmovie);
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color:
                                  movie_to_wishlist.contains(currentmovie)
                                      ? Colors.red
                                      : Colors.white70,
                                )),
                          ),
                        );
                      }))
            ],
          )),
    );
  }
}
