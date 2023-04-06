// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:zmovies/widgets/topRated.dart';
import 'package:zmovies/widgets/trending.dart';
import 'package:zmovies/widgets/tvShows.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;
  List trendingMovies = [];
  List topRatedMovies = [];
  List TvShows = [];
  final String apiKey = '77bfac3e735bd3fb5316e8934779544d';
  final String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3N2JmYWMzZTczNWJkM2ZiNTMxNmU4OTM0Nzc5NTQ0ZCIsInN1YiI6IjYzOTAzYTM5ZjEwYTFhMDA5Yjc3MDgwNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ihMqPh5YzhvP519QtfyLraHp3YOWdKRkrYT-stSRYmM';

  loadMovies() async {
    TMDB tmdbEithCustomLogs = TMDB(
      ApiKeys(apiKey, accessToken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
    );

    Map trendingResult = await tmdbEithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbEithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbEithCustomLogs.v3.tv.getPopular();
    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResult['results'];
      TvShows = tvResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 6, 11),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
      
            ZoomDrawer.of(context)!.toggle();
          },
          child: SizedBox(
            height: 20,
            width: 20,
            child: Lottie.network(
              'https://assets5.lottiefiles.com/packages/lf20_PEXuG7.json',
            ),
          ),
        ),
        title: 'Zmovies'.text.xl5.white.bold.make().shimmer(
            duration: const Duration(seconds: 4),
            primaryColor: Colors.white,
            secondaryColor: const Color.fromARGB(100, 64, 9, 73)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          tvShows(tvshows: TvShows),
          TrendingMovies(trending: trendingMovies),
          TopRated(topRated: topRatedMovies),
        ],
      ),
    );
  }
}
