import 'package:flutter/material.dart';
import 'package:hero_admin/pages/navigation.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: const Text('REVIEWS', style: TextStyle(
            color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
        )),
        backgroundColor: Colors.white,
      ),
      body:
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("My Reviews",
                  style: TextStyle( fontSize: 20,fontWeight: FontWeight.bold)),
              SizedBox(height: 30),

              Row(
                children: [
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {
                      },
                      starCount: 5,
                      rating: 4,
                      size: 25.0,
                      isReadOnly:true,

                      color: Color(0xFFff9100),
                      borderColor: Color(0xFFff9100),
                      spacing:0.0
                  ),
                  SizedBox(width: 15),
                  Text("07/02/20",
                      style: TextStyle(color: Colors.grey, fontSize: 12))
                ],
              ),
              SizedBox(height: 5),
              Text("Aaron Cruz",
                  style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold)),
              Text("Magaling sya, nalilinis ng maayos ang bahay.",
                  style: TextStyle( fontSize: 15)),

              SizedBox(height: 25),
              Row(
                children: [
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {
                      },
                      starCount: 5,
                      rating: 4,
                      size: 25.0,
                      isReadOnly:true,

                      color: Color(0xFFff9100),
                      borderColor: Color(0xFFff9100),
                      spacing:0.0
                  ),
                  SizedBox(width: 10),
                  Text("07/02/20",
                      style: TextStyle(color: Colors.grey, fontSize: 12))
                ],
              ),
              SizedBox(height: 5),
              Text("Melissa Chavez",
                  style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold)),
              Text("Satisfied naman ako. Medyo na-late lang sya pero okay lang naman. Good service.",
                  style: TextStyle( fontSize: 15)),


            ],
          ),
        ),
      ),
    );
  }
}
