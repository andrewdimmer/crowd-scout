import 'package:crowd_scout/elements/searchAppbar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title, this.initialSearchString}) : super(key: key);

  final String title;
  final String initialSearchString;

  @override
  State<StatefulWidget> createState() {
    return _SearchPage(initialSearchString);
  }
}

class _SearchPage extends State<SearchPage> {
  _SearchPage(String initialSearchString) {
    _initialSearchString = initialSearchString;
    _search(initialSearchString, true);
  }

  String _initialSearchString;
  bool _busySearching = true;
  List<Widget> _searchResults = [];

  void _resetSearchBox() {
    setState(() {
      _initialSearchString = "";
    });
  }

  Future<void> _search(String input, [bool initialLoad = false]) async {
    if (!initialLoad) {
      setState(() {
        _busySearching = true;
        _initialSearchString = input;
      });
    }
    // Run Async Function Here
    Future<List<Widget>> results = Future.delayed(
        Duration(seconds: 2),
        () => [
              Center(child: Text("Results")),
              Text(input + " " + 1.toString() + "TEST______"),
              Text(input + " " + 2.toString()),
              Text(input + " " + 3.toString())
            ]);
    setSearchResults(await results);
  }

  void setSearchResults(List<Widget> results) {
    setState(() {
      _searchResults = results;
      _busySearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(
          title: widget.title,
          toggleSearch: _resetSearchBox,
          onSearch: (string) => _search(string),
          defaultSearchString: _initialSearchString),
      body: _busySearching
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  CircularProgressIndicator(),
                  Center(child: Text("Searching..."))
                ])
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _searchResults,
            ),
    );
  }
}
