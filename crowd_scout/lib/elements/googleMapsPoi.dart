import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPoi {
  GoogleMapsPoi(
      {this.formattedAddress,
      this.icon,
      this.name,
      this.location,
      this.businessStatus,
      this.placeId,
      this.types,
      this.photos});

  final String businessStatus;
  final String formattedAddress;
  final String icon;
  final String name;
  final LatLng location;
  final String placeId;
  final List<String> types;
  final List<GoogleMapsPoiPhoto> photos;
}

class GoogleMapsPoiPhoto {
  GoogleMapsPoiPhoto({this.height, this.width, this.photoReference});

  final String photoReference;
  final num height;
  final num width;
}
