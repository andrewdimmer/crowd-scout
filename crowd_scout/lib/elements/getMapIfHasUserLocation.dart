import 'dart:async';
import 'dart:convert';

import 'package:crowd_scout/elements/googleMapsPoi.dart';
import 'package:crowd_scout/elements/loadingWheelAndMessage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Widget getMapIfHasUserLocation(
  GeolocationStatus permission,
  Position position,
  Completer<GoogleMapController> controllerPointer,
  Widget mapWidgetPointer,
  Function refreshPermissions,
  LatLng poiLocation,
  Function setController,
  Function setPoi,
) =>
    (permission == GeolocationStatus.granted)
        ? (position != null)
            ? (controllerPointer != null)
                ? mapWidgetPointer
                : GoogleMap(
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: (poiLocation != null)
                          ? poiLocation
                          : LatLng(position.latitude, position.longitude),
                      zoom: 17,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      setController(controller);
                    },
                    onTap: (data) async {
                      print(data);
                      http.Response response = await http.get(
                          "https://us-central1-tohacks2020-gcp.cloudfunctions.net/helloWorld");
                      print(response.body);
                      http.Response placeData = await http.post(
                          "https://us-central1-tohacks2020-gcp.cloudfunctions.net/get_nearby_places_from_lat_long",
                          body: data.latitude.toString() +
                              ";" +
                              data.longitude.toString() +
                              ";150");
                      var poiRaw = jsonDecode(placeData.body)["results"][1];
                      setPoi(GoogleMapsPoi(
                          businessStatus: poiRaw["business_status"],
                          formattedAddress: poiRaw["vicinity"],
                          name: poiRaw["name"],
                          types: poiRaw["types"]
                              .map<String>((item) => item.toString())
                              .toList(),
                          icon: poiRaw["icon"],
                          placeId: poiRaw["place_id"],
                          photos: poiRaw["photos"]
                              .map<GoogleMapsPoiPhoto>((photo) =>
                                  GoogleMapsPoiPhoto(
                                    height: poiRaw["height"],
                                    width: poiRaw["width"],
                                    photoReference: poiRaw["photo_reference"],
                                  ))
                              .toList(),
                          location: LatLng(
                            poiRaw["geometry"]["location"]["lat"],
                            poiRaw["geometry"]["location"]["lng"],
                          )));
                    },
                  )
            : loadingWheelAndMessage("Loading Location...")
        : Column(
            children: <Widget>[
              Center(
                child: Text(
                  "This app needs access to location services in order to run.",
                ),
              ),
              IconButton(
                  icon: Icon(Icons.refresh),
                  tooltip: "Recheck Permissions",
                  onPressed: refreshPermissions),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          );
