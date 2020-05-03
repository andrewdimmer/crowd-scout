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
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  poiInfo.name,
                  style: TextStyle(fontSize: 24.0),
                ),
                Text(
                  poiInfo.formattedAddress,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            padding: EdgeInsets.all(8.0),
          ),
        ),
        onTap: _onTapFactory(context),
      );
}
