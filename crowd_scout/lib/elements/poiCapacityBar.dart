import 'package:crowd_scout/elements/MapPoint.dart';
import 'package:crowd_scout/widgets/ChangeCapacityPage.dart';
import 'package:flutter/material.dart';

class PoiCapacityBar extends StatefulWidget {
  PoiCapacityBar({Key key, this.poiMapPoint}) : super(key: key);

  final MapPoint poiMapPoint;

  @override
  State<StatefulWidget> createState() => _PoiCapacityBar(poiMapPoint);
}

class _PoiCapacityBar extends State<PoiCapacityBar> {
  _PoiCapacityBar(MapPoint poiMapPoint) {
    _poiMapPoint = poiMapPoint;
    _getCrowdInformation(true);
  }

  MapPoint _poiMapPoint;
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
            poiMapPoint: _poiMapPoint,
            updateLocalCapacity: _updateLocalCapacity,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Container(
        child: _busyLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    CircularProgressIndicator(),
                    Center(child: Text("Loading..."))
                  ])
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
