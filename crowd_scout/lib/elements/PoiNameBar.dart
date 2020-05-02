import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PoiNameBar extends StatelessWidget {
  PoiNameBar({Key key, this.poiName, this.poiAddress, this.onClose})
      : super(key: key);

  final String poiName;
  final String poiAddress;
  final Function onClose;

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[Text(poiName), Text(poiAddress)],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            tooltip: "Close Information Box",
            onPressed: onClose,
          )
        ],
      ),
      decoration: BoxDecoration(color: ThemeData.light().primaryColorLight),
    );
  }
}
