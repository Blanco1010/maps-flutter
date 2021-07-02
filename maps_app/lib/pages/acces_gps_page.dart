import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccesGpsPage extends StatefulWidget {
  @override
  _AccesGpsPageState createState() => _AccesGpsPageState();
}

class _AccesGpsPageState extends State<AccesGpsPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('======>  $state ');

    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('It is necessary to use the GPS'),
          MaterialButton(
            color: Colors.black,
            shape: StadiumBorder(),
            elevation: 0,
            splashColor: Colors.transparent,
            child: Text(
              'Request access',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              final status = await Permission.location.request();
              this.accesGPS(status);
            },
          )
        ],
      )),
    );
  }

  void accesGPS(PermissionStatus status) {
    // print(status);
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'map');
        break;

      case PermissionStatus.limited:
        print('LIMITED!');
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}
