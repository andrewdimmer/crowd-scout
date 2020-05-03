import 'package:crowd_scout/elements/MapPoint.dart';
import 'package:crowd_scout/elements/loadingWheelAndMessage.dart';
import 'package:crowd_scout/elements/searchAppbar.dart';
import 'package:crowd_scout/widgets/PoiSearchResultItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title, this.initialSearchString, this.setPoi})
      : super(key: key);

  final String title;
  final String initialSearchString;
  final Function setPoi;

  @override
  State<StatefulWidget> createState() =>
      _SearchPage(initialSearchString, setPoi);
}

class _SearchPage extends State<SearchPage> {
  _SearchPage(String initialSearchString, Function setPoi) {
    _initialSearchString = initialSearchString;
    _search(initialSearchString, true);
    _setPoi = setPoi;
  }

  String _initialSearchString;
  bool _busySearching = true;
  List<Widget> _searchResults = [];
  Function _setPoi;

  void _resetSearchBox() => setState(() {
        _initialSearchString = "";
      });

  Future<void> _search(String input, [bool initialLoad = false]) async {
    if (!initialLoad) {
      setState(() {
        _busySearching = true;
        _initialSearchString = input;
      });
    }
    var testResults = await http.get("https://flutter.dev");
    print(testResults.body.toString());
    Future<List<MapPoint>> results = Future.delayed(
        Duration(seconds: 2),
        () => [
              MapPoint(
                name: input + " " + 1.toString(),
                address: input + ", City, State 0000" + 1.toString(),
              ),
              MapPoint(
                name: input + " " + 2.toString(),
                address: input + ", City, State 0000" + 2.toString(),
              ),
              MapPoint(
                name: input + " " + 3.toString(),
                address: input + ", City, State 0000" + 3.toString(),
              ),
            ]);
    setSearchResults(await results);
  }

  void setSearchResults(List<MapPoint> results) {
    List<Widget> newSearchResults = [Center(child: Text("Results"))];
    newSearchResults.addAll(
      results.map(
        (mapPoint) =>
            PoiSearchResultItem(poiMapPoint: mapPoint, setPoi: _setPoi),
      ),
    );
    setState(() {
      _searchResults = newSearchResults;
      _busySearching = false;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: searchAppBar(
            title: widget.title,
            toggleSearch: _resetSearchBox,
            onSearch: (string) => _search(string),
            defaultSearchString: _initialSearchString),
        body: _busySearching
            ? loadingWheelAndMessage("Searching...")
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _searchResults,
              ),
      );
}
