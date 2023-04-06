// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:zmovies/description.dart';
import 'package:zmovies/utils/style.dart';

class TopRated extends StatelessWidget {
  final List topRated;
  const TopRated({super.key, required this.topRated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Textstyle(text: 'Top Rated Movies', color: Colors.white, size: 20),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRated.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Description(
                              name: topRated[index]['original_title'],
                              description: topRated[index]['overview'],
                              bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                                  topRated[index]['backdrop_path'],
                              posterUrl: 'https://image.tmdb.org/t/p/w500' +
                                  topRated[index]['poster_path'],
                              rating:
                                  topRated[index]['vote_average'].toString(),
                              launchedOn: topRated[index]['release_date'])));
                    },
                    child: SizedBox(
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
                                      topRated[index]['poster_path'],
                                ),
                              ),
                            ),
                          ),
                          Textstyle(
                              text: topRated[index]['original_title'] ?? 'loading',
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
