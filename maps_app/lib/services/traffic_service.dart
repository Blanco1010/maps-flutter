import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/helpers/debouncer.dart';
import 'package:maps_app/models/reserve_response.dart';
import 'package:maps_app/models/search_response.dart';
import 'package:maps_app/models/traffic_response.dart';

class TrafficService {
  void dispose() {
    _emergenceStreamControl.close();
  }

  //Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();

  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400));

  final StreamController<SearchResponse> _emergenceStreamControl =
      new StreamController<SearchResponse>.broadcast();

  Stream<SearchResponse> get emergenceStream =>
      this._emergenceStreamControl.stream;

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
    print('Buscando!!!');

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

// final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500 ));

  //Await a while to call function. avoid asking many request to API
  void getSugerenciasPorQuery(String busqueda, LatLng proximidad) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final resultados = await this.getResultWithQuery(value, proximidad);
      this._emergenceStreamControl.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }

  Future<ReverseResponse> getCoordinateInfo(LatLng destinationCoords) async {
    final url =
        '$_baseUrlGeo/mapbox.places/${destinationCoords.longitude},${destinationCoords.latitude}.json';

    final resp = await this._dio.get(url, queryParameters: {
      'access_token': _apiKey,
      'language': 'es',
    });

    final _data = reverseResponseFromJson(resp.data);

    return _data;
  }
}
