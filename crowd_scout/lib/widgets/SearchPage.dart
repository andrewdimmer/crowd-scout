import 'dart:convert';

import 'package:crowd_scout/elements/googleMapsPoi.dart';
import 'package:crowd_scout/elements/loadingWheelAndMessage.dart';
import 'package:crowd_scout/elements/searchAppbar.dart';
import 'package:crowd_scout/widgets/PoiSearchResultItem.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  SearchPage(
      {Key key,
      this.title,
      this.initialSearchString,
      this.setPoi,
      this.userLocation})
      : super(key: key);

  final String title;
  final String initialSearchString;
  final Function setPoi;
  final Position userLocation;

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
    http.Response response = await http.get(
        "https://us-central1-tohacks2020-gcp.cloudfunctions.net/helloWorld");
    print(response.body.toString());
    http.Response testResults = await http.post(
        "https://us-central1-tohacks2020-gcp.cloudfunctions.net/get_places_from_search",
        body: widget.userLocation.latitude.toString() +
            ";" +
            widget.userLocation.longitude.toString() +
            ";" +
            input);
    var locations = jsonDecode(testResults.body);
    print(locations);
    List<GoogleMapsPoi> results = locations["candidates"]
        .map<GoogleMapsPoi>((item) => GoogleMapsPoi(
            businessStatus: item["business_status"],
            formattedAddress: item["formatted_address"],
            name: item["name"],
            types:
                item["types"].map<String>((item) => item.toString()).toList(),
            icon: item["icon"],
            placeId: item["place_id"],
            photos: item["photos"]
                .map<GoogleMapsPoiPhoto>((photo) => GoogleMapsPoiPhoto(
                      height: item["height"],
                      width: item["width"],
                      photoReference: item["photo_reference"],
                    ))
                .toList(),
            location: LatLng(
              item["geometry"]["location"]["lat"],
              item["geometry"]["location"]["lng"],
            )))
        .toList();
    setSearchResults(results);
  }

  void setSearchResults(List<GoogleMapsPoi> results) {
    List<Widget> newSearchResults = [
      Center(child: Text("Results", style: TextStyle(fontSize: 18)))
    ];
    newSearchResults.addAll(
      results.map(
        (poiInfo) => PoiSearchResultItem(poiInfo: poiInfo, setPoi: _setPoi),
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
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _searchResults,
                ),
                padding: EdgeInsets.all(8.0),
              ),
      );
}
