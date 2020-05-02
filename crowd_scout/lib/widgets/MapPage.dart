import 'package:crowd_scout/elements/PoiNameBar.dart';
import 'package:crowd_scout/elements/MapPoint.dart';
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
  MapPoint _userLocation;
  MapPoint _mapCenter;
  MapPoint _poi =
      MapPoint(lat: 0, long: 0, name: "Test Name", address: "Test Address");

  void _toggleSearch() => setState(() {
        _searching = !_searching;
      });

  void _setPoi(newPoi) => setState(() {
        _poi = newPoi;
        //_mapCenter = MapPoint(lat: _userLocation.lat, long: _userLocation.long);
      });

  List<Widget> _generateMapPageBody() {
    List<Widget> mapPageBody = [Text("Map")];
    if (_poi != null) {
      mapPageBody.insert(
          0,
          PoiNameBar(
            poiName: _poi.name,
            poiAddress: _poi.address,
            onClose: () => _setPoi(null),
          ));
      mapPageBody.add(Text("POI Info"));
    }
    return mapPageBody;
  }

  Function _onSearchFactory(BuildContext context) => (String input) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(
                title: "Search Page",
                initialSearchString: input,
                setPoi: _setPoi),
          ),
        );
        _toggleSearch();
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: searchAppBar(
          title: widget.title,
          searching: this._searching,
          toggleSearch: this._toggleSearch,
          autofocus: true,
          onSearch: _onSearchFactory(context),
        ),
        body: Column(
          children: _generateMapPageBody(),
        ),
      );
}
