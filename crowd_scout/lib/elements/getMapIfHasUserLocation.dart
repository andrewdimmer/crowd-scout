import 'dart:async';

import 'package:crowd_scout/elements/loadingWheelAndMessage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget getMapIfHasUserLocation(
  GeolocationStatus permission,
  Position position,
  Completer<GoogleMapController> controllerPointer,
  Widget mapWidgetPointer,
  Function refreshPermissions,
) =>
    (permission == GeolocationStatus.granted)
        ? position != null
            ? (controllerPointer != null)
                ? mapWidgetPointer
                : GoogleMap(
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 15,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      print(DateTime.now().toString() + " Rendering map...");
                      controllerPointer = Completer();
                      controllerPointer.complete(controller);
                    },
                    onTap: (data) => print(data),
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
