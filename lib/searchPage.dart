import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:search_app/detailsScreen.dart';
import 'package:search_app/searchForm.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.title}) : super(key: key);

  final String title;
  final dio = Dio();

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var news;
  List<dynamic> newsHits = [];

  Future<void> searchRestaurants(String query) async {
    final Response response = await widget.dio.get(
      'http://hn.algolia.com/api/v1/search?query=$query',
    );
    setState(() {
      news = jsonDecode(response.toString());
    });
    newsHits = news['hits'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.purple[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          SearchForm(
            onSearch: searchRestaurants,
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: news == null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(140, 0, 50, 0),
                    child: Column(children: [
                      Icon(Icons.search, size: 100, color: Colors.grey[800]),
                      Text("nothing to show",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 15,
                          )),
                    ]),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: newsHits.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      objectID: newsHits[index]['objectID'],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  // color: Colors.grey[300],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text((newsHits[index]['url']).toString(),
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          )),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        newsHits[index]['title'],
                                        style: TextStyle(
                                            color: Colors.purple[300],
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(children: [
                                        Text(
                                          'author - ',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          newsHits[index]['author'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ]),
                                      Row(
                                        children: [
                                          Text(
                                            'points - ',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            (newsHits[index]['points'])
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
