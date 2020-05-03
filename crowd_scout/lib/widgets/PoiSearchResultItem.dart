import 'package:crowd_scout/elements/MapPoint.dart';
import 'package:flutter/material.dart';

class PoiSearchResultItem extends StatelessWidget {
  PoiSearchResultItem({Key key, this.poiMapPoint, this.setPoi})
      : super(key: key);

  final MapPoint poiMapPoint;
  final Function setPoi;

  Function _onTapFactory(context) => () {
        setPoi(poiMapPoint);
        Navigator.pop(context);
      };

  Widget build(BuildContext context) => GestureDetector(
        child: Card(
          child: Column(
            children: <Widget>[
              Text(poiMapPoint.name),
              Text(poiMapPoint.address),
            ],
          ),
        ),
        onTap: _onTapFactory(context),
      );
}
