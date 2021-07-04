import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/my_ubication/my_ubication_bloc.dart';

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
      body: BlocBuilder<MyUbicationBloc, MyUbicationState>(
          builder: (_, state) => createMap(state)),
    );
  }

  Widget createMap(MyUbicationState state) {
    if (state.existUbication == false) {
      return Center(child: CircularProgressIndicator(strokeWidth: 2));
    } else {
      return Text('${state.ubication?.longitude},${state.ubication?.latitude}');
    }
  }
}
