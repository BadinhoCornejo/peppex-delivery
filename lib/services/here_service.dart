import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:peppex_delivery/models/models.dart';

class HereService {
  final routeToken = 'W2spTZDns3QSKPnFOoQ_FXE937EBGKeOG3bWvQwipeY';
  final searchToken =
      'eyJhbGciOiJSUzUxMiIsImN0eSI6IkpXVCIsImlzcyI6IkhFUkUiLCJhaWQiOiJNeDBVdXFIRjRWcTA5ZWQ5RzU2YiIsImlhdCI6MTYwNjg4MTAxMCwiZXhwIjoxNjA2OTY3NDEwLCJraWQiOiJqMSJ9.ZXlKaGJHY2lPaUprYVhJaUxDSmxibU1pT2lKQk1qVTJRMEpETFVoVE5URXlJbjAuLmpVdXpKTlhLcnNqdzVxbGdTSTk5TlEuY1pBUGpocVFDcHJCSGh1VEJYRVpNTGc0aXQzYmZQQk1IQWxJakZ5YmpEZUYtNlZnajFFV0xmLVVoZERjeWthaFo4b0I1Ti16bGpyNzM1dXkxWmZjbTFqb1FteVRmbkRyd1QyWVFBR3RqSUltOUd0RDFXMUtFRVVGZzZWa2VZYUxQejh0MnRNaWdsbUJJTmxKV2RHM2t3LkRvYVJuM1VRTFN3bGFlZndoeldtanZxa1JiYlpyU1Nra0ViUDQwOFdPVVE.V2iStBXZ4x7t2MZb4S-n0K1tfDbqDE5rbSND7ULHHsFubA-7awUN944JjKqngVwjlI-nBoMgZgJtlux8znJgSg63MMwjN-uQ00DKBNUck26yLLkBHlZ6zrZKXG3OGDiB8xwkzvhkuGfGxQ2aYc53ro6JPoBPKZSqVb3J2g6c4loKW96eEd20SQmMlrf4ylCgqDd_t1ws6n5L437rWFb5Ay44q_gx-GatCoMEIB5M4yRnEE6PSLL1wQT7plpES_3iq_DisYz6Jc8p0-PbcSGtd90AhfSORc6wQxuEopa3J4QT3QZWm1VoBHJNHKJsyb261gkLRhUUh57PrA3MdTryXg';

  final peppexAddress = LatLng(-8.10153555900095, -79.03410791796358);

  Future<LocationModel> getMyLocationAddress(String address) async {
    try {
      Dio dio = new Dio();
      dio.options.headers['Authorization'] = 'Bearer $searchToken';

      String q = '$address, Trujillo, Perú';

      Response res = await dio.get(
        'https://geocode.search.hereapi.com/v1/geocode',
        queryParameters: {'q': q},
      );


      if (res.statusCode == 200) {
        Map<String, dynamic> locationItem = res.data['items'][0];
        return new LocationModel.fromJson(locationItem);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<LatLng>> getMyRoute(LocationModel location) async {
    try {
      Dio dio = new Dio();

      String waypoint0 =
          'geo!${peppexAddress.latitude},${peppexAddress.longitude}';
      String waypoint1 =
          'geo!${location.position.latitude},${location.position.longitude}';
      String mode = 'fastest;car;traffic:disabled';
      String representation = 'display';

      String url =
          'https://route.ls.hereapi.com/routing/7.2/calculateroute.json';

      Response res = await dio.get(
        url,
        queryParameters: {
          'apiKey': routeToken,
          'waypoint0': waypoint0,
          'waypoint1': waypoint1,
          'mode': mode,
          'representation': representation,
        },
      );

      if (res.statusCode == 200) {
        List<LatLng> waypoints = new List<LatLng>();
        List<String> shape = new List<String>();
        res.data['response']['route'][0]['shape'].forEach((s) {
          shape.add(s);
        });

        shape.forEach((element) {
          List<String> coor = element.split(',');
          num lat = num.parse(coor[0]);
          num lng = num.parse(coor[1]);

          waypoints.add(new LatLng(lat, lng));
        });

        return waypoints;
      }
    } catch (e) {
      print(e);
    }
  }
}
