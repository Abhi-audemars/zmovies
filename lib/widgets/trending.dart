import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:zmovies/description.dart';
import 'package:zmovies/utils/style.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;
  const TrendingMovies({super.key, required this.trending});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Textstyle(text: 'Trending Movies', color: Colors.white, size: 20),
          SizedBox(
            height: 10,
          ),
          Container(
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
                        ? Container(
                            width: 140,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
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
                                Container(
                                  child: Textstyle(
                                      text: trending[index]['name']==null? trending[index]['title']:trending[index]['name']  ,
                                      // != null
                                      //     ? trending[index]['name']
                                      //     : 'loading',
                                      color: Color.fromARGB(255, 165, 163, 163),
                                      size: 12),
                                )
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
