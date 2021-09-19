import 'dart:ui';

import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  SearchForm({required this.onSearch});

  final void Function(String search) onSearch;

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  var _autovalidate = false;
  var _search;

  @override
  Widget build(BuildContext context) {
    return Form(
      // ignore: deprecated_member_use
      autovalidate: _autovalidate,
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              style: TextStyle(
                  color: Colors.purple[300],
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.purple[300],
                ),
                hintText: 'Search Here',
                hintStyle: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),

                focusColor: Colors.redAccent[400],
                border: OutlineInputBorder(),
                // fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.pink, width: 4.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.purple, width: 2.0),
                ),
                filled: true,
              ),
              onChanged: (value) {
                _search = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter';
                }
                return null;
              }),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                final isValid = _formKey.currentState!.validate();
                if (isValid) {
                  widget.onSearch(_search);
                } else {
                  setState(() {
                    _autovalidate = true;
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple[300]),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
