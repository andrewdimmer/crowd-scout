import 'package:crowd_scout/elements/searchAppbar.dart';
import 'package:crowd_scout/widgets/SearchPage.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MapPage();
  }
}

class _MapPage extends State<MapPage> {
  bool _searching = false;

  void _toggleSearch() {
    setState(() {
      _searching = !_searching;
    });
  }

  Function _onSearchFactory(BuildContext context) => (String input) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(
              title: "Search Page",
              initialSearchString: input,
            ),
          ),
        );
        _toggleSearch();
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(
        title: widget.title,
        searching: this._searching,
        toggleSearch: this._toggleSearch,
        autofocus: true,
        onSearch: _onSearchFactory(context),
      ),
    );
  }
}
