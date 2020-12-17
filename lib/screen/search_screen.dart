import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/model/model_movie.dart';
import 'package:netflix_clone/screen/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController(); // 검색 위젯을 컨트롤 하는 _filter위젯
  FocusNode focusNode = FocusNode(); // 현재 검색 위젯에 커서가 있는지에 대한 상태등을 가지고 있는 위젯
  String _searchText = ""; // 현재 검색 값

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text; // _fliter가 변화를 감지하여 searchText의 상태를 변화시키는 코드
      });
    });
  }

  // _buildbody를 통해 스트림데이터를 가져와 _buildList를 호출하고,
  // _buildList에서는 검색 결과에 따라 데이터를 처리해 GridView를 생성합니다.
  // GridView에 들어갈 아이템들은 _biildListItem으로 만들고 각각 DetailScreen을 띄울 수 있도록 만들었습니다.

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(), //Firebase내의 movies컬렉션 스냅샷 가져오기
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator(); // 데이터를 아직 못가져왔다면 로딩화면
        return _buildList(context, snapshot.data.docs); // 가져왔다면 _buildList를 호출하여 리스트를 만듭니다.
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot d in snapshot) {
      if (d.data.toString().contains(_searchText)) {
        searchResults.add(d);
      }
    }
    return Expanded(
      child: GridView.count( //GridView.count를 활용해 1/1.5 비율의 위젯을 만든다.
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.5, 
          padding: EdgeInsets.all(3),
          children: searchResults
              .map((data) => _buildListItem(context, data))
              .toList()),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final movie = Movie.fromSnapshot(data); // 인자로 넘겨받은 data를 Movie.fromSnapshot을 통해 Movie 타입으로 변환
    return InkWell(
      child: Image.network(movie.poster),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movie: movie);
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: Icon(
                        Icons.search, // 검색 아이콘
                        color: Colors.white60,
                        size: 20,
                      ),
                      suffixIcon: focusNode.hasFocus // suffixIcon: 우측에 배치될 아이콘
                          ? IconButton(
                              icon: Icon(
                                Icons.cancel, // 커서가 있을때 X버튼 띄우기
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchText = ""; // 초기화
                                });
                              },
                            )
                          : Container(), // 커서가 없으면 빈 상태
                      hintText: '검색',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent), // 투명하게
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent), // 투명하게
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent), // 투명하게
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                focusNode.hasFocus
                    ? Expanded(
                        child: FlatButton(
                          child: Text('취소'), // Focus가 있을때만 취소버튼 나옴
                          onPressed: () {
                            setState(() {
                              _filter.clear();
                              _searchText = "";
                              focusNode.unfocus(); // 활성화된 키보드 내려감
                            });
                          },
                        ),
                      )
                    : Expanded(
                        flex: 0,
                        child: Container(), // Focus가 없으면 빈 화면
                      )
              ],
            ),
          ),
          _buildBody(context) // 검색결과 화면 호출
        ],
      ),
    );
  }
}