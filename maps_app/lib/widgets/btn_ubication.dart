part of 'widgets.dart';

class BtnUbication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapsBloc>(context);
    final myUbication = BlocProvider.of<MyUbicationBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
          onPressed: () {
            final destination = myUbication.state.ubication;
            mapBloc.moveCamera(destination!);
          },
        ),
      ),
    );
  }
}
