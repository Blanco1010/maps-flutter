import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/bloc/my_ubication/my_ubication_bloc.dart';
import 'package:maps_app/bloc/map/maps_bloc.dart';
import 'package:maps_app/widgets/widgets.dart';

class MapGpsPage extends StatefulWidget {
  @override
  _MapGpsPageState createState() => _MapGpsPageState();
}

class _MapGpsPageState extends State<MapGpsPage> {
  @override
  void initState() {
    //Declare the bloc for call a method initialFollow
    BlocProvider.of<MyUbicationBloc>(context).initialFollow();

    super.initState();
  }

  @override
  void dispose() {
    print('CANCEL');
    // BlocProvider.of<MyUbicationBloc>(context).cancelFollow();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MyUbicationBloc, MyUbicationState>(
            builder: (_, state) => createMap(state),
          ),
          // Make the toggle when i'm manually

          Positioned(top: 10, child: SearchBar()),
          MarkerManual()
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbication(),
          BtnFollow(),
          BtnDraw(),
        ],
      ),
    );
  }

  Widget createMap(MyUbicationState state) {
    if (state.existUbication == false) {
      return Center(child: CircularProgressIndicator(strokeWidth: 2));
    } else {
      final mapBloc = BlocProvider.of<MapsBloc>(context);

      mapBloc.add(OnLocationUpdate(state.ubication!));

      final cameraPosition = new CameraPosition(
        target: state.ubication!,
        zoom: 15,
      );

      return BlocBuilder<MapsBloc, MapsState>(builder: (context, _) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          compassEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          polylines: mapBloc.state.polylines!.values.toSet(),
          onMapCreated: (GoogleMapController controller) =>
              mapBloc.initMap(controller),
          onCameraMove: (cameraPosition) {
            mapBloc.add(OnMoveMap(cameraPosition.target));
          },
        );
      });
    }
  }
}
