// ignore_for_file: camel_case_types, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:zmovies/description.dart';
import 'package:zmovies/utils/style.dart';

class tvShows extends StatelessWidget {
  final List tvshows;
  const tvShows({super.key, required this.tvshows});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Textstyle(text: 'Popular TV Shows', color: Colors.white, size: 20),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tvshows.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Description(
                            name: tvshows[index]['name'],
                            description: tvshows[index]['overview'],
                            bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                                tvshows[index]['backdrop_path'],
                            posterUrl: 'https://image.tmdb.org/t/p/w500' +
                                tvshows[index]['poster_path'],
                            rating: tvshows[index]['vote_average'].toString(),
                            launchedOn: tvshows[index]['first_air_date'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 6),
                      width: 250,
                      child: Column(
                        children: [
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 250,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        tvshows[index]['backdrop_path'],
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Textstyle(
                              text: tvshows[index]['name'] ?? 'loading',
                              color: const Color.fromARGB(255, 165, 163, 163),
                              size: 12)
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
