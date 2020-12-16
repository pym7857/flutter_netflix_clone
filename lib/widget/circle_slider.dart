import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';

class CircleSlider extends StatelessWidget {
  // home_screen.dart에서 movies를 넘겨 받아야 합니다.
  final List<Movie> movies;
  CircleSlider({this.movies}); // 생성자로 movies를 받아옵니다.

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('미리보기'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal, // 횡단 스크롤이 되는 ListView
              children: makeCircleImages(movies),
            )
          ),
        ],
      )
    );
  }
}

List<Widget> makeCircleImages(List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(
      InkWell( // 클릭 가능하도록 InkWell 위젯으로 설정
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(  // CircleAvatar로 원형 위젯을 만들기
              backgroundImage: AssetImage('images/' + movies[i].poster),
            )
          )
        )
      ),
    );
  }
}