import 'package:mapbox_gl/mapbox_gl.dart';

class LocationModel {
  String id;
  String title;
  LatLng position;

  LocationModel({this.id, this.title, this.position});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      title: json['title'],
      position: new LatLng(
        json['position']['lat'],
        json['position']['lng'],
      ),
    );
  }
}
