part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.selectManual) {
          return Container();
        } else {
          return FadeInDown(child: buildSearchBar(context));
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {
            final proximity =
                BlocProvider.of<MyUbicationBloc>(context).state.ubication;

            final history = BlocProvider.of<SearchBloc>(context).state.history;

            final result = await showSearch(
              context: context,
              delegate: SearchDestination(proximity!, history!),
            );
            this.returnSearch(context, result!);
          },
          child: Container(
            padding: EdgeInsets.only(top: 20, left: 20),
            width: width,
            height: 50,
            child: Text(
              '¿Dónde quieres ir?',
              style: TextStyle(color: Colors.black87),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 10),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Future returnSearch(BuildContext context, SearchResult result) async {
    // When to call the function,return depending on booleans
    if (result.cancel) {
      print('Prueba');
      return;
    }

    //If manual is true to call the function
    if (result.manual) {
      BlocProvider.of<SearchBloc>(context).add(OnActiveMarkerManual());
      return;
    }

    calculateAlert(context);

    //Calculate the route in base to value: Result
    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapsBloc>(context);

    final initial = BlocProvider.of<MyUbicationBloc>(context).state.ubication;
    final destination = result.position;

    // get the traffic response
    final drivingTraffic =
        await trafficService.getCoordsStartAndEnd(initial!, destination!);

    // get the objets to use decode
    final geometry = drivingTraffic.routes[0].geometry;
    final duration = drivingTraffic.routes[0].duration;
    final distance = drivingTraffic.routes[0].distance;

    //Decode the points of goemtry
    PolylinePoints _polylinePoints = PolylinePoints();
    final points = _polylinePoints.decodePolyline(geometry);

    // convert to LatLng
    final List<LatLng> routeCoords =
        points.map((e) => LatLng(e.latitude, e.longitude)).toList();

    print(routeCoords);

    Navigator.of(context).pop();
    mapBloc.add(OnCreateRouteInitialEnd(routeCoords, distance, duration));

    //Add a history
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc.add(OnAddHistory(result));
  }
}
