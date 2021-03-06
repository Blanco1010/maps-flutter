import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/bloc/map/maps_bloc.dart';
import 'package:maps_app/bloc/my_ubication/my_ubication_bloc.dart';
import 'package:maps_app/bloc/search/search_bloc.dart';

import 'package:maps_app/models/search_result.dart';
import 'package:maps_app/search/search_destination.dart';
import 'package:maps_app/services/traffic_service.dart';

part 'searchbar.dart';
part 'btn_ubication.dart';
part 'btn_draw.dart';
part 'btn_follow.dart';
part 'marker_manual.dart';
