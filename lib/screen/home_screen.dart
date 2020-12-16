import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'package:netflix_clone/widget/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 더미 데이터
  List<Movie> movies = [
    Movie.fromMap(
      {
        'title': 'Wash Day',
        'keyword': '자동차/공업사/렌트카',
        'poster': 'test_car.jpg',
        'like': false
      }
    )
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[   // Stack의 경우 children안에 선언한 순서대로 밑에부터 깔리게 됩니다.
            CarouselImage(movies: movies),
            TobBar(),
          ],
        )
      ],
    );
  }
}

class TobBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 간격 조정
        children: <Widget>[
          Image.asset(
            'images/bbongflix_logo.jpg',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '첫번째 메뉴',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '두번째 메뉴',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '세번째 메뉴',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}