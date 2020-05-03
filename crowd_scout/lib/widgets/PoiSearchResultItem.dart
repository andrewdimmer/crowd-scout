import 'package:crowd_scout/elements/googleMapsPoi.dart';
import 'package:flutter/material.dart';

class PoiSearchResultItem extends StatelessWidget {
  PoiSearchResultItem({Key key, this.poiInfo, this.setPoi}) : super(key: key);

  final GoogleMapsPoi poiInfo;
  final Function setPoi;

  Function _onTapFactory(BuildContext context) => () {
        setPoi(poiInfo);
        Navigator.pop(context);
      };

  Widget build(BuildContext context) => GestureDetector(
        child: Card(
          child: Column(
            children: <Widget>[
              Text(poiInfo.name),
              Text(poiInfo.formattedAddress),
            ],
          ),
        ),
        onTap: _onTapFactory(context),
      );
}
