import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/models/models.dart';
import 'package:peppex_delivery/services/here_service.dart';
import 'package:peppex_delivery/ui/components/myorder_map.dart';
import 'package:peppex_delivery/ui/screens/home.dart';

class MapPage extends StatelessWidget {
  final OrderController orderController = OrderController.to;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final HereService here = new HereService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi pedido',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.off(Home());
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<OrderModel>(
          future: orderController.getActiveOrder(
            _db.collection('users').doc(
                  _auth.currentUser.uid,
                ),
          ),
          builder: (BuildContext context, AsyncSnapshot<OrderModel> snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder<LocationModel>(
                future: here.getMyLocationAddress(snapshot.data.address),
                builder: (BuildContext context,
                    AsyncSnapshot<LocationModel> location) {
                  if (location.hasData) {
                    return FutureBuilder<List<LatLng>>(
                      future: here.getMyRoute(location.data),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<LatLng>> snapshot) {
                        if (snapshot.hasData) {
                          LatLng origin = new LatLng(
                            -8.10153555900095,
                            -79.03410791796358,
                          );
                          return MyOrderMap(
                            target: location.data.title,
                            origin: origin,
                            waypoints: snapshot.data,
                          );
                        } else {
                          return Expanded(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  Center(
                                    child: Text(
                                      'Generando ruta',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No pudimos encontrar tu ubicación.',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Nuestro equipo se pondrá en contacto al número que ingresate en la orden.',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return Container(
                child: Center(
                  child: Text(
                    'Al parecer no tienes una orden activa',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
