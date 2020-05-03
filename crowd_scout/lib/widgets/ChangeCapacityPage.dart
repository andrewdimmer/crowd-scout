import 'package:crowd_scout/elements/googleMapsPoi.dart';
import 'package:flutter/material.dart';

class ChangeCapacityPage extends StatelessWidget {
  ChangeCapacityPage({Key key, this.poiInfo, this.updateLocalCapacity})
      : super(key: key);

  final GoogleMapsPoi poiInfo;
  final Function updateLocalCapacity;

  Function _onSubmitFactory(BuildContext context) => (String input) {
        String inputClean = input
            .replaceAll(",", "")
            .replaceAll(" ", "")
            .replaceAll("-", "")
            .replaceAll(".", "");
        updateLocalCapacity(inputClean);
        Navigator.pop(context);
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Update Capacity for " + poiInfo.name)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Update capacity"),
            TextField(
              autofocus: true,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(hintText: "Enter a new capacity"),
              keyboardType: TextInputType.number,
              onSubmitted: _onSubmitFactory(context),
            )
          ],
        ),
      );
}
