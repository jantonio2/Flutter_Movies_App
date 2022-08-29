import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatelessWidget {

  final List<Movie> movies;
  final String? title;

  const MovieSlider({
    Key? key,
    required this.movies,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if(title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          const SizedBox(height: 5),
          if(movies.isEmpty)
            SizedBox(
              width: double.infinity,
              height: size.height * 0.2,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.indigo),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: ( _, int index ) => _MoviePoster( movie: movies[index] ),
              ),
            )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;

  const _MoviePoster({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
