import 'package:crowd_scout/elements/googleMapsPoi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangeCapacityPage extends StatelessWidget {
  ChangeCapacityPage({Key key, this.poiInfo}) : super(key: key);

  final GoogleMapsPoi poiInfo;

  Function _onSubmitFactory(BuildContext context) => (String input) {
        String inputClean = input
            .replaceAll(",", "")
            .replaceAll(" ", "")
            .replaceAll("-", "")
            .replaceAll(".", "");
        http.post(
            "https://us-central1-tohacks2020-gcp.cloudfunctions.net/update_capacity",
            body: (inputClean.length == 0 ? "?" : inputClean) +
                ";" +
                poiInfo.placeId);
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
