import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:zmovies/description.dart';
import 'package:zmovies/utils/style.dart';

class tvShows extends StatelessWidget {
  final List tvshows;
  const tvShows({super.key, required this.tvshows});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Textstyle(text: 'Popular TV Shows', color: Colors.white, size: 20),
          SizedBox(
            height: 10,
          ),
          Container(
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
                      padding: EdgeInsets.only(left: 6),
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
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Textstyle(
                                text: tvshows[index]['name'] != null
                                    ? tvshows[index]['name']
                                    : 'loading',
                                color: Color.fromARGB(255, 165, 163, 163),
                                size: 12),
                          )
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
