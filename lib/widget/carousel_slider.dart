import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'package:netflix_clone/screen/detail_screen.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  CarouselImage({this.movies}); // CarouselImage생성자를 통해 movies를 가져온다.
  _CarouselImageState createState() => _CarouselImageState(); // 상태관리
}

class _CarouselImageState extends State<CarouselImage> {
  // state로 관리해줄 변수들을 선언
  List<Movie> movies;
  List<Widget> images;
  List<String> keywords;
  List<bool> likes;
  int _currentPage = 0; // CarouselImage에서 어느 위치에 있는지 index를 저장할 _currentPage
  String _currentKeyword; // 그 페이지에 기록되어있는 현재 키워드

  @override
  void initState() { // 상위 클래스인 StatefulWidget에서 가져온 movies를 참조할 수 있도록 값을 가져온다.
    super.initState();
    movies = widget.movies; // state로 관리하는 변수들의 초기값을 선언한다.
    // map을 통해 movies로 부터 원하는 값들만 모아 리스트 형태로 만든다.
    //images = movies.map((m) => Image.asset('./images/' + m.poster)).toList();
    images = movies.map((m) => Image.network(m.poster)).toList();
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keywords[0]; // 초기값 선언
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
          ),
          // CarouselSlider 위젯을 만들어 items에 images, 페이지 전환을 처리하는 onPageChanged를 setState()와 함께 처리합니다.
          CarouselSlider( // 20.4.16일자로 문법 이렇게 번경
            items: images, 
            options: CarouselOptions(onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
                _currentKeyword = keywords[_currentPage];
              });
            }), 
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: TextStyle(fontSize: 11),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 가운데에 같은 간격으로 정렬
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      // likes[_currentPage]가 true일때는 체크 아이콘, false일때는 플러스 아이콘이 나오게 됩니다.
                      likes[_currentPage]
                      ? IconButton(
                        icon: Icon(Icons.check), 
                        onPressed: () {
                          setState(() {
                            likes[_currentPage] = !likes[_currentPage];
                            movies[_currentPage].reference.update(
                              {
                                'like': likes[_currentPage]
                              }
                            );
                          });
                        },)
                      : IconButton(
                        icon: Icon(Icons.add), 
                        onPressed: () {
                          setState(() {
                            likes[_currentPage] = !likes[_currentPage];
                            movies[_currentPage].reference.update(
                              {
                                'like': likes[_currentPage]
                              }
                            );
                          });
                        },),
                      Text(
                        '내가 찜한 콘텐츠',
                        style: TextStyle(fontSize: 11),
                      )
                    ]
                  )
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: FlatButton(
                    color: Colors.white,
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow, // 재생 아이콘
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                        ),
                        Text(
                          '재생',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () { // 정보(info)버튼을 누르면, 해당 영화 정보가 인자로 넘어가 DetailScreen 화면이 보여집니다.
                          // MatarialPageRoute를 통해 팝업창을 띄웁니다.
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                            fullscreenDialog: true, 
                            builder: (BuildContext context) {
                              return DetailScreen(
                                movie: movies[_currentPage],
                              );
                            }));
                        },
                      ),
                      Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(likes, _currentPage),
            )
          ),
        ],
      )
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> results = []; // results에 컨테이너를 add하는 방식으로 진행
  for (var i = 0; i < list.length; i++) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // 현재 페이지를 가리키고 있다면 투명도 0.9, 아니라면 0.4
        color: _currentPage == i
          ? Color.fromRGBO(255, 255, 255, 0.9) 
          : Color.fromRGBO(255, 255, 255, 0.4),
      ),
    ));
  }

  return results;
}