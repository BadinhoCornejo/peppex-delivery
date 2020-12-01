import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:peppex_delivery/models/models.dart';

class HereService {
  final routeToken = 'W2spTZDns3QSKPnFOoQ_FXE937EBGKeOG3bWvQwipeY';
  final searchToken =
      'eyJhbGciOiJSUzUxMiIsImN0eSI6IkpXVCIsImlzcyI6IkhFUkUiLCJhaWQiOiJNeDBVdXFIRjRWcTA5ZWQ5RzU2YiIsImlhdCI6MTYwNjc3MTU5MywiZXhwIjoxNjA2ODU3OTkzLCJraWQiOiJqMSJ9.ZXlKaGJHY2lPaUprYVhJaUxDSmxibU1pT2lKQk1qVTJRMEpETFVoVE5URXlJbjAuLjV6LUhrSFJYZkYtY21pTHZvczB2bXcuTFRsaEE1Nld1QkJTMXlaZUxXT2RhMjRCNW5MZDlvUHk4WHZrNmNONVctYXp6aV9SUGxiNGpzajAzcmRuUnM0elpEZkg4SFlqSXFtdWh2NDQwbS1ENkhIXzY0d2pTWTZDV2tMWFZIbk9CM05rZUNoejNBb0R4WTRKSThKck1YcnRqTnlxMF9MRUpLTF91Vjg0ZFQ1MzZ3Lkl4LXN1Z2V6cTlGMS1idXBqc2VCd3VBMXNMeEVOaG1Xem5mTlEwa3d6SUk.kXCciaxPQqKeFjaztAf2NKSw_KSs6TROALKPyQ-yEhSvwr0CUEwcoGZjLT4yJqMFDIKOQrkQy5aHKodQfdabHiApFj61oAOHvD5224NGzRQPxoY2sOtIw9htctQiR9I_rmoWGVdAwgqfEqSbcM733AZ1uUGkPk26u3Z9tULN4m5EUdxalUbG8lHIDngShuAKYZXQ1hwYZdkp-H2Q4b0tHmdCWTiNDpiVAMxEx_AbWFSzedytu7X8d2V_ON7_Mkk6PwW2XhYUbDP7reyg_Ypxmzjld11T7K9zq_AA6yN__UMeJZ16wpE52k9N8UtO2wSsRrnE0uBYoxMXEFiXG-nsFg';

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
