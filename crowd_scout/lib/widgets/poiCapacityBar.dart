import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowd_scout/elements/googleMapsPoi.dart';
import 'package:crowd_scout/elements/loadingWheelAndMessage.dart';
import 'package:crowd_scout/widgets/ChangeCapacityPage.dart';
import 'package:flutter/material.dart';

class PoiCapacityBar extends StatefulWidget {
  PoiCapacityBar({Key key, this.poiInfo}) : super(key: key);

  final GoogleMapsPoi poiInfo;

  @override
  State<StatefulWidget> createState() => _PoiCapacityBar(poiInfo);
}

class _PoiCapacityBar extends State<PoiCapacityBar> {
  _PoiCapacityBar(GoogleMapsPoi poiInfo) {
    _poiInfo = poiInfo;
    _getCrowdInformation(true);
    Firestore.instance.collection("PLACEHOLDER").getDocuments().then((value) =>
        print("Firestore Test Successful: " + value.documents.toString()));
  }

  GoogleMapsPoi _poiInfo;
  bool _busyLoading = true;
  int _crowd;
  int _capacity;

  Future<void> _getCrowdInformation([bool initialLoad = false]) async {
    if (!initialLoad) {
      setState(() {
        _busyLoading = true;
      });
    }
    // Run Async Function Here
    Future.delayed(
        Duration(seconds: 2),
        () => setState(() {
              _crowd = 7;
              _capacity = 10;
              _busyLoading = false;
            }));
  }

  void _updateLocalCapacity(String newCapacity) => setState(() {
        _capacity = int.parse(newCapacity);
      });

  void openUpdateCapacity() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeCapacityPage(
            poiInfo: _poiInfo,
            updateLocalCapacity: _updateLocalCapacity,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Container(
        child: _busyLoading
            ? loadingWheelAndMessage("Loading Crowd and Capacity Data...")
            : Column(
                children: <Widget>[
                  Center(
                    child:
                        Text(_crowd.toString() + " / " + _capacity.toString()),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        child:
                            Text("Know the capacity? Update the max capacity!"),
                        color: Theme.of(context).primaryColorDark,
                        onPressed: openUpdateCapacity,
                      )
                    ],
                    alignment: MainAxisAlignment.center,
                  )
                ],
              ),
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
      );
}
