// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:zmovies/description.dart';
import 'package:zmovies/utils/style.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;
  const TrendingMovies({super.key, required this.trending});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Textstyle(text: 'Trending Movies', color: Colors.white, size: 20),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trending.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Description(
                            name: trending[index]['name'],
                            description: trending[index]['overview'],
                            bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                                trending[index]['backdrop_path'],
                            posterUrl: 'https://image.tmdb.org/t/p/w500' +
                                trending[index]['poster_path'],
                            rating: trending[index]['vote_average'].toString(),
                            launchedOn: trending[index]['first_air_date'],
                          ),
                        ),
                      );
                    },
                    child: trending[index]['name'] != null
                        ? SizedBox(
                            width: 140,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  // margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            trending[index]['poster_path'],
                                      ),
                                    ),
                                  ),
                                ),
                                Textstyle(
                                    text: trending[index]['name'] ?? trending[index]['title']  ,
                                   
                                    color: const Color.fromARGB(255, 165, 163, 163),
                                    size: 12)
                              ],
                            ),
                          )
                        : Container(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
