import 'dart:async';

import 'package:crowd_scout/elements/MapPoint.dart';
import 'package:crowd_scout/elements/poiCapacityBar.dart';
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
    Geolocator()
        .getPositionStream(
          LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10),
        )
        .listen(_setUserLocation);
  }

  bool _searching = false;
  Position _userLocation;
  MapPoint _mapCenter;
  MapPoint _poi;
  // MapPoint(lat: 0, long: 0, name: "Test Name", address: "Test Address");
  Completer<GoogleMapController> _controller;

  void _toggleSearch() => setState(() {
        _searching = !_searching;
      });

  void _setPoi(newPoi) => setState(() {
        _poi = newPoi;
        //_mapCenter = MapPoint(lat: _userLocation.lat, long: _userLocation.long);
      });

  List<Widget> _generateMapPageBody() {
    List<Widget> mapPageBody = [
      Container(
        child: Expanded(
          child: GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(_userLocation.latitude, _userLocation.longitude),
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = Completer();
              _controller.complete(controller);
            },
            onTap: (data) => print(data),
          ),
        ),
      )
    ];
    if (_poi != null) {
      mapPageBody.insert(
        0,
        PoiNameBar(
          poiMapPoint: _poi,
          onClose: () => _setPoi(null),
        ),
      );
      mapPageBody.add(PoiCapacityBar(poiMapPoint: _poi));
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

  void _setUserLocation(Position userPosition) {
    setState(() {
      _userLocation = userPosition;
    });
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
