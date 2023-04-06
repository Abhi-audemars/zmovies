import 'package:flutter/material.dart';
import 'package:zmovies/utils/style.dart';

class Description extends StatelessWidget {
  final String name, description, bannerUrl, posterUrl, rating, launchedOn;
  const Description(
      {super.key,
      required this.name,
      required this.description,
      required this.bannerUrl,
      required this.posterUrl,
      required this.rating,
      required this.launchedOn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: Image.network(
                        bannerUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Text(
                      '   ⭐' + rating,
                      style:const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    // child: Textstyle(
                    //     text: '  ⭐' + rating, color: Colors.white, size: 15),
                  )
                ],
              ),
            ),
           const SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Textstyle(
                  text: name != null ? name : 'no name',
                  color: Colors.white,
                  size: 25),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Released on: ' + launchedOn,
                style:const TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 205, 204, 204)),
              ),
            ),
           const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  padding:const EdgeInsets.all(5),
                  height: 150,
                  width: 110,
                  child: Image.network(
                    posterUrl,
                    fit: BoxFit.cover,
                  ),
                ),
               const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Container(
                    height: 150,
                    child: Textstyle(
                        text: description, color: Colors.white, size: 11),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
