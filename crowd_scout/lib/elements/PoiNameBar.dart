import 'package:crowd_scout/elements/MapPoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PoiNameBar extends StatelessWidget {
  PoiNameBar({Key key, this.poiMapPoint, this.onClose}) : super(key: key);

  final MapPoint poiMapPoint;
  final Function onClose;

  Widget build(BuildContext context) => Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(poiMapPoint.name),
                  Text(poiMapPoint.address)
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              tooltip: "Close Information Box",
              onPressed: onClose,
            )
          ],
        ),
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
      );
}
