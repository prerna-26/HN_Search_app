import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  final String objectID;
  DetailsScreen({required this.objectID});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var detailsData;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response = await http.get(
        Uri.parse("http://hn.algolia.com/api/v1/items/${widget.objectID}"));

    setState(() {
      detailsData = jsonDecode(response.body);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple[300],
              title: Text(
                detailsData['title'],
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  detailsData['title'],
                  style: TextStyle(
                    color: Colors.purple[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  ('Points - ${detailsData['points']}').toString(),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 280.0),
                  child: Text(
                    'Comments',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(height: 3.5, color: Colors.white60),
                SizedBox(
                  height: 17,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: detailsData['children'].length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                )),
                                child: Text(
                                  detailsData['children'][index]['text'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
