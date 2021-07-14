part of 'widgets.dart';

class MarkerManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.selectManual) {
          return _BuildMarkerManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarkerManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        //Return button
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 500),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  BlocProvider.of<SearchBloc>(context).add(
                    OnDeactivateMarkerManual(),
                  );
                },
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -20),
            child: BounceInDown(
              from: 200,
              child: Icon(
                Icons.location_on,
                size: 50,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            duration: Duration(seconds: 1),
            child: MaterialButton(
              minWidth: width - 120,
              child: Text(
                'Confirmar destino',
                style: TextStyle(color: Colors.white),
              ),
              shape: StadiumBorder(),
              splashColor: Colors.transparent,
              elevation: 0,
              color: Colors.black,
              onPressed: () {
                this.calculateDestination(context);
              },
            ),
          ),
        )
        //Button destination confirm
      ],
    );
  }

  void calculateDestination(BuildContext context) async {
    calculateAlert(context);

    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapsBloc>(context);

    final start = BlocProvider.of<MyUbicationBloc>(context).state.ubication;
    final end = mapBloc.state.centralUbication;

    //Get information about ubication
    trafficService.getCoordinateInfo(end!);

    // get the traffic response
    final trafficResponse =
        await trafficService.getCoordsStartAndEnd(start!, end);

    // get the objets to use decode

    final geometry = trafficResponse.routes[0].geometry;
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;

    //Decode the points of goemtry
    PolylinePoints _polylinePoints = PolylinePoints();
    final points = _polylinePoints.decodePolyline(geometry);

    // convert to LatLng
    final List<LatLng> routeCoords =
        points.map((e) => LatLng(e.latitude, e.longitude)).toList();

    print(routeCoords);
    mapBloc.add(OnCreateRouteInitialEnd(routeCoords, distance, duration));

    Navigator.of(context).pop();
    BlocProvider.of<SearchBloc>(context).add(OnDeactivateMarkerManual());
  }
}
