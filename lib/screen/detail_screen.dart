import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  DetailScreen({this.movie});
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;

  @override
  void initState() {
    super.initState();
    like = widget.movie.like; // 해당 영화에 대한 찜하기 상태를 가져오겠습니다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold와 SafeArea로 기본 골격을 잡아준다.
      body: Container(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration( // BoxDecoration을 활용해 포스터를 넣기
                      image: DecorationImage(
                        //image: AssetImage('images/' + widget.movie.poster),
                        image: NetworkImage(widget.movie.poster),
                        fit: BoxFit.cover,
                      )
                    ), 
                    child: ClipRect( // ClipRect와 BackdropFilter를 이용해 이미지를 blur처리
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), //blur
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.1),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                  //child: Image.asset('images/' + widget.movie.poster), // blur위에 이미지 띄우기
                                  child: Image.network(widget.movie.poster),
                                  height: 300,
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    '99% 일치 2019 15+ 공업사 1개',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13),
                                  ), 
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    widget.movie.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  child: FlatButton(
                                    onPressed: () {}, 
                                    color: Colors.red, // 배경 색
                                    child: Row(
                                      mainAxisAlignment: 
                                        MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.play_arrow),
                                        Text('재생'),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(widget.movie.toString()),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '책임자: OO, OOO',
                                    style: TextStyle(
                                      color: Colors.white60, 
                                      fontSize: 12
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    child: AppBar(
                      backgroundColor: Colors.transparent, // AppBar를 투명하게.. → 팝업 다이얼로그에 기본으로 적용되어있던 닫기버튼이 모습을 들어냄
                      elevation: 0,
                    )
                  ),
                ],
              ),
              Container(
                color: Colors.black26,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            like = !like;
                            widget.movie.reference.update(
                              {
                              'like': like
                              }
                            );
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            like ? Icon(Icons.check) : Icon(Icons.add),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              '내가 찜한 공업사', 
                              style: TextStyle(
                                fontSize: 11, 
                                color: Colors.white60,
                              )
                            )
                          ],
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.thumb_up),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              '평가',
                              style: TextStyle(
                                fontSize: 11, color: Colors.white60
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.send),
                            Padding(padding: EdgeInsets.all(5),),
                            Text(
                              '공유',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}