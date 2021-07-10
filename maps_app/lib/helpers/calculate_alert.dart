part of 'helpers.dart';

void calculateAlert(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Espere por favor'),
        content: Text('Calculando ruta'),
      ),
    );
  } else {
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
            title: Text('Espere por favor'),
            content: CupertinoActivityIndicator()));
  }
}
