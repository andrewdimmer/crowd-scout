import 'package:crowd_scout/widgets/MapPage.dart';
import 'package:flutter/material.dart';
import 'MapPoint.dart';

class PoiSearchResultItem extends StatelessWidget {
  PoiSearchResultItem({Key key, this.poiMapPoint, this.setPoi})
      : super(key: key);

  final MapPoint poiMapPoint;
  final Function setPoi;

  Function _onTapFactory(context) {
    return () {
      setPoi(poiMapPoint);
      Navigator.pop(context);
    };
  }

  Widget build(BuildContext context) {
    return GestureDetector(
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
}
