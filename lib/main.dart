import 'package:flutter/material.dart';
import 'package:netflix_clone/screen/home_screen.dart';
import 'package:netflix_clone/screen/like_screen.dart';
import 'package:netflix_clone/screen/more_screen.dart';
import 'package:netflix_clone/screen/search_screen.dart';
import 'package:netflix_clone/widget/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {  // Stateful: 상태관리 필요
  _MyAppState createState() => _MyAppState(); // createState(): 상태관리
}

class _MyAppState extends State<MyApp> {
  TabController controller; // TabController를 전역에 선언
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YMFlix',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(), // 손가락으로 탭 못 넘기게
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              LikeScreen(),
              MoreScreen(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}