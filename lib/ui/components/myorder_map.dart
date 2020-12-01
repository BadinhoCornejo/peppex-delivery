import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:peppex_delivery/constants/peppex_icons.dart';

class MyOrderMap extends StatefulWidget {
  final String target;
  final LatLng origin;
  final List<LatLng> waypoints;

  MyOrderMap({
    Key key,
    @required this.target,
    @required this.origin,
    @required this.waypoints,
  }) : super(key: key);

  @override
  _MyOrderMapState createState() => _MyOrderMapState();
}

class _MyOrderMapState extends State<MyOrderMap> {
  MapboxMapController mapController;

  final streetsStyle =
      'mapbox://styles/badinhocornejo/ckhcudgzh0rf619qjglbcocll';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onLocationLoaded() {
    mapController.addSymbol(
      SymbolOptions(
        geometry: widget.origin,
        iconImage: 'myorder',
        iconSize: 2,
      ),
    );
    mapController.addSymbol(
      SymbolOptions(
        geometry: widget.waypoints.last,
        iconImage: 'me',
        iconSize: 2,
      ),
    );
    mapController.addLine(
      LineOptions(
        geometry: widget.waypoints,
        lineColor: "#ffcc00",
        lineWidth: 4,
      ),
    );
  }

  void _onStyleLoaded() {
    addImageFromAsset("me", "assets/images/me.png");
    addImageFromAsset("myorder", "assets/images/myorder.png");
  }

  // Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  // Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(url);
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MapboxMap(
          onMapCreated: _onMapCreated,
          onStyleLoadedCallback: _onLocationLoaded,
          styleString: streetsStyle,
          initialCameraPosition: CameraPosition(
            target: widget.origin,
            zoom: 14,
            tilt: 50,
          ),
        ),
        Positioned.fill(
          top: 8,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 361,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Peppex.whh_foodtray,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 311,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 24,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Isaac Albeniz 443, Trujillo',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 36,
                        ),
                        Container(
                          height: 24,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.target,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
