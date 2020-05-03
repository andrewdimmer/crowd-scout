import 'package:crowd_scout/elements/googleMapsPoi.dart';
import 'package:flutter/material.dart';

class PoiNameBar extends StatelessWidget {
  PoiNameBar({Key key, this.poiInfo, this.onClose}) : super(key: key);

  final GoogleMapsPoi poiInfo;
  final Function onClose;

  Widget build(BuildContext context) => Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(poiInfo.name),
                  Text(poiInfo.formattedAddress)
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
