part of 'helpers.dart';

//widget to png fot image initial
Future<BitmapDescriptor> getMarkerInitialIcon(int seconds) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(300, 150);

  final minute = (seconds / 60).floor();

  final markerInitial = new MarkerInitialPainter(minute);
  markerInitial.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

//widget to png fot image destination
Future<BitmapDescriptor> getMarkerDestinationIcon(
    String description, double metres) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(300, 150);

  final markerInitial = new MarkerDestinationPainter(description, metres);
  markerInitial.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}
