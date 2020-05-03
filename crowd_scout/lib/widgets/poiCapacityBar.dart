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
    var snapshots = Firestore.instance
        .collection("places")
        .document(poiInfo.placeId)
        .snapshots();
    snapshots.listen(_processNewCrowdAndCapacityData);
  }

  GoogleMapsPoi _poiInfo;
  bool _busyLoading = false;
  int _crowd = 0;
  String _capacity = "?";

  void _processNewCrowdAndCapacityData(DocumentSnapshot snapshot) {
    setState(() {
      _crowd = snapshot.exists ? snapshot.data["crowd"] : 0;
      _capacity = snapshot.exists ? snapshot.data["capacity"] : "?";
    });
  }

  void _openUpdateCapacity() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeCapacityPage(
            poiInfo: _poiInfo,
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
                    child: Text(_crowd.toString() + " / " + _capacity,
                        style: TextStyle(fontSize: 24)),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        child:
                            Text("Know the capacity? Update the max capacity!"),
                        color: Theme.of(context).primaryColorDark,
                        onPressed: _openUpdateCapacity,
                      )
                    ],
                    alignment: MainAxisAlignment.center,
                  )
                ],
              ),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
      );
}
