part of 'helpers.dart';

Future<BitmapDescriptor> getAssetImageMarker() async {
  return await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(), 'assets/custom-pin.png');
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final resp = await Dio().get(
    'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );
  final bytes = resp.data;

  final imageCodec = await ui.instantiateImageCodec(bytes,
      targetHeight: 130, targetWidth: 130);

  final frame = await imageCodec.getNextFrame();

  final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
