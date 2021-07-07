part of 'widgets.dart';

class BtnDraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapsBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.linear_scale_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            mapBloc.add(OnChangeDraw());
          },
        ),
      ),
    );
  }
}
