part of 'widgets.dart';

class BtnFollow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsBloc, MapsState>(
        builder: (context, state) => _createButton(state, context));
  }

  Widget _createButton(MapsState state, BuildContext context) {
    final mapBloc = BlocProvider.of<MapsBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            state.followUbication
                ? Icons.directions_run
                : Icons.accessibility_new,
            color: Colors.black,
          ),
          onPressed: () {
            mapBloc.add(OnFollowUbication());
          },
        ),
      ),
    );
  }
}
