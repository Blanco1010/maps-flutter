part of 'widgets.dart';

class MarkerManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        //Return button
        Positioned(
          top: 70,
          left: 20,
          child: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                //TODO: do something
              },
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -20),
            child: Icon(
              Icons.location_on,
              size: 50,
            ),
          ),
        ),

        Positioned(
          bottom: 70,
          left: 40,
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
            onPressed: () {},
          ),
        )
        //Button destination confirm
      ],
    );
  }
}
