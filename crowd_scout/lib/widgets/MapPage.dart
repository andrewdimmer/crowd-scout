import 'dart:async';

import 'package:crowd_scout/elements/MapPoint.dart';
import 'package:crowd_scout/elements/getMapIfHasUserLocation.dart';
import 'package:crowd_scout/elements/googleMapsPoi.dart';
import 'package:crowd_scout/elements/loadingWheelAndMessage.dart';
import 'package:crowd_scout/elements/searchAppbar.dart';
import 'package:crowd_scout/widgets/PoiNameBar.dart';
import 'package:crowd_scout/widgets/SearchPage.dart';
import 'package:crowd_scout/widgets/poiCapacityBar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MapPage();
  }
}

class _MapPage extends State<MapPage> {
  _MapPage() {
    print("Adding Listener");
    _addLocationListener();
    _renderMapWidget();
  }

  bool _searching = false;
  Position _userLocation;
  GoogleMapsPoi _poi;
  Completer<GoogleMapController> _controller;
  Widget _mapWidget = loadingWheelAndMessage("Initalizing...");

  void _toggleSearch() {
    print(_userLocation);
    if (_userLocation != null) {
      setState(() {
        _searching = !_searching;
      });
    }
  }

  void _setPoi(newPoi) => setState(() {
        _poi = newPoi;
        //_mapCenter = MapPoint(lat: _userLocation.lat, long: _userLocation.long);
      });

  void _renderMapWidget() async {
    GeolocationStatus permission =
        await Geolocator().checkGeolocationPermissionStatus();
    setState(
      () {
        _mapWidget = getMapIfHasUserLocation(
          permission,
          _userLocation,
          _controller,
          _mapWidget,
          _addLocationListener,
        );
      },
    );
  }

  void _addLocationListener() {
    Geolocator()
        .getPositionStream(
          LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10),
        )
        .listen(_setUserLocation);
  }

  List<Widget> _generateMapPageBody() {
    List<Widget> mapPageBody = [
      Container(
        child: Expanded(
          child: _mapWidget,
        ),
      )
    ];
    if (_poi != null) {
      mapPageBody.insert(
        0,
        PoiNameBar(
          poiInfo: _poi,
          onClose: () => _setPoi(null),
        ),
      );
      mapPageBody.add(PoiCapacityBar(poiInfo: _poi));
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
              setPoi: _setPoi,
              userLocation: _userLocation,
            ),
          ),
        );
        _toggleSearch();
      };

  void _setUserLocation(Position userPosition) {
    setState(() {
      _userLocation = userPosition;
    });
    _renderMapWidget();
  }

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
