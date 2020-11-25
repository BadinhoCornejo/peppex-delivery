import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:peppex_delivery/constants/peppex_icons.dart';

class MyOrderMap extends StatefulWidget {
  @override
  _MyOrderMapState createState() => _MyOrderMapState();
}

class _MyOrderMapState extends State<MyOrderMap> {
  MapboxMapController mapController;
  final origin = LatLng(-8.10153555900095, -79.03410791796358);
  final dest = LatLng(-8.139669837909947, -79.03803760044188);
  final streetsStyle =
      'mapbox://styles/badinhocornejo/ckhcudgzh0rf619qjglbcocll';
  final waypoints = <LatLng>[
    new LatLng(-8.10153555900095, -79.03410791796358),
    new LatLng(-8.1014853, -79.034219),
    new LatLng(-8.1016445, -79.0342927),
    new LatLng(-8.1019127, -79.0338528),
    new LatLng(-8.1024921, -79.0327585),
    new LatLng(-8.1039405, -79.0335631),
    new LatLng(-8.1048846, -79.0340567),
    new LatLng(-8.1051528, -79.034282),
    new LatLng(-8.1052816, -79.0345073),
    new LatLng(-8.1053245, -79.0347111),
    new LatLng(-8.1052816, -79.034915),
    new LatLng(-8.1050885, -79.0353334),
    new LatLng(-8.105067, -79.0354514),
    new LatLng(-8.1050777, -79.0355694),
    new LatLng(-8.1050992, -79.0356231),
    new LatLng(-8.1052065, -79.0357625),
    new LatLng(-8.1057537, -79.03602),
    new LatLng(-8.1061506, -79.0362024),
    new LatLng(-8.1079102, -79.036932),
    new LatLng(-8.1088328, -79.0372968),
    new LatLng(-8.109262, -79.0375757),
    new LatLng(-8.1098843, -79.0381014),
    new LatLng(-8.1099808, -79.0381873),
    new LatLng(-8.1116867, -79.0357304),
    new LatLng(-8.1122553, -79.0349579),
    new LatLng(-8.1125987, -79.0345395),
    new LatLng(-8.1147766, -79.0364277),
    new LatLng(-8.1156349, -79.0371466),
    new LatLng(-8.1175983, -79.0388525),
    new LatLng(-8.1192613, -79.0402687),
    new LatLng(-8.1192183, -79.0403652),
    new LatLng(-8.1192183, -79.040451),
    new LatLng(-8.1192827, -79.0406334),
    new LatLng(-8.11939, -79.0407193),
    new LatLng(-8.1195188, -79.0407407),
    new LatLng(-8.119626, -79.0407193),
    new LatLng(-8.1197333, -79.0406764),
    new LatLng(-8.1198192, -79.0405905),
    new LatLng(-8.1198514, -79.0405047),
    new LatLng(-8.1198514, -79.0404081),
    new LatLng(-8.1214499, -79.039861),
    new LatLng(-8.1240249, -79.0390241),
    new LatLng(-8.1243896, -79.0390027),
    new LatLng(-8.1245935, -79.0390563),
    new LatLng(-8.1246901, -79.0390241),
    new LatLng(-8.1247652, -79.0389705),
    new LatLng(-8.1247973, -79.0388954),
    new LatLng(-8.1248188, -79.0387881),
    new LatLng(-8.1247652, -79.0386379),
    new LatLng(-8.1247544, -79.0384448),
    new LatLng(-8.1247544, -79.0383053),
    new LatLng(-8.1247759, -79.0381873),
    new LatLng(-8.1257415, -79.0357411),
    new LatLng(-8.127265, -79.0363741),
    new LatLng(-8.1282949, -79.0367281),
    new LatLng(-8.1293786, -79.0371251),
    new LatLng(-8.1295073, -79.0370822),
    new LatLng(-8.129797, -79.0371251),
    new LatLng(-8.1333053, -79.038316),
    new LatLng(-8.1334341, -79.0382516),
    new LatLng(-8.1340027, -79.037683),
    new LatLng(-8.1350327, -79.0367067),
    new LatLng(-8.1354189, -79.0371037),
    new LatLng(-8.1356013, -79.0372002),
    new LatLng(-8.1357193, -79.0372431),
    new LatLng(-8.1371248, -79.0376079),
    new LatLng(-8.1374359, -79.0377367),
    new LatLng(-8.1375432, -79.037801),
    new LatLng(-8.1376398, -79.0377474),
    new LatLng(-8.1379294, -79.0367067),
    new LatLng(-8.1381869, -79.035902),
    new LatLng(-8.1387341, -79.0360951),
    new LatLng(-8.1386268, -79.0364063),
    new LatLng(-8.1385732, -79.0368462),
    new LatLng(-8.1386054, -79.0371895),
    new LatLng(-8.138659, -79.0373826),
    new LatLng(-8.1387985, -79.0377045),
    new LatLng(-8.1389916, -79.0379405),
    new LatLng(-8.1391633, -79.0380907),
    new LatLng(-8.139521, -79.0383132),
    new LatLng(-8.139669837909947, -79.03803760044188)
  ];

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

  void _onStyleLoaded() {
    addImageFromAsset("me", "assets/images/me.png");
    addImageFromAsset("myorder", "assets/images/myorder.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  void _onLocationLoaded() {
    mapController.addSymbol(
      SymbolOptions(
        geometry: origin,
        iconImage: 'myorder',
        iconSize: 2,
      ),
    );
    mapController.addSymbol(
      SymbolOptions(
        geometry: dest,
        iconImage: 'me',
        iconSize: 2,
      ),
    );
    mapController.addLine(
      LineOptions(
        geometry: waypoints,
        lineColor: "#ffcc00",
        lineWidth: 4,
      ),
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi pedido',
        ),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            MapboxMap(
              onMapCreated: _onMapCreated,
              onStyleLoadedCallback: _onLocationLoaded,
              styleString: streetsStyle,
              initialCameraPosition: CameraPosition(
                target: origin,
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
                                  'Isaac Albeniz 316, Trujillo',
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
                                  'H, Distrito de Víctor Larco Herrera 13009',
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
        ),
      ),
    );
  }
}
