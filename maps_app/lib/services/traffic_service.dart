import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/search_response.dart';
import 'package:maps_app/models/traffic_response.dart';

class TrafficService {
  //Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final String _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final String _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final String _apiKey =
      'pk.eyJ1Ijoia296bDk4IiwiYSI6ImNrcXZtdDJvMzBhenoyb256cWJyZWF1OHMifQ.csPvWTfm8_PKJgikSr999g';

  Future<DrivingResponse> getCoordsStartAndEnd(LatLng start, LatLng end) async {
    // print('start:$start');
    // print('end  :$end');

    final coordString =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '$_baseUrlDir/mapbox/driving/$coordString';

    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline',
      'steps': 'false',
      'access_token': _apiKey,
      'language': 'es',
    });

    final _data = DrivingResponse.fromJson(resp.data);

    return _data;
  }

  Future<SearchResponse> getResultWithQuery(
      String search, LatLng proximity) async {
    final url = '${this._baseUrlGeo}/mapbox.places/$search!.json';

    try {
      final resp = await this._dio.get(url, queryParameters: {
        'access_token': this._apiKey,
        'cachebuster': '1626031008098',
        'autocomplete': 'true',
        'proximity': '${proximity.longitude},${proximity.latitude}',
        'language': 'es'
      });

      final searchResponde = searchResponseFromJson(resp.data);

      return searchResponde;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }
}
