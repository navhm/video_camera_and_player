// void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
//   if (controller == null) {
//     return;
//   }
//
//   final CameraController cameraController = controller!;
//
//   final offset = Offset(
//     details.localPosition.dx / constraints.maxWidth,
//     details.localPosition.dy / constraints.maxHeight,
//   );
//   cameraController.setExposurePoint(offset);
//   cameraController.setFocusPoint(offset);
// }
//
// // onViewFinderTap(details, constraints),
//
// //
// // GestureDetector(
// // behavior: HitTestBehavior.opaque,
// // onScaleStart: _handleScaleStart,
// // onScaleUpdate: _handleScaleUpdate,
// // onTapDown: (details) => onViewFinderTap(details, constraints),
// // );
//
// void _handleScaleStart(ScaleStartDetails details) {
//   _baseScale = _currentScale;
// }
//
// Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
//   // When there are not exactly two fingers on screen don't scale
//   if (controller == null || _pointers != 2) {
//     return;
//   }
//
//   _currentScale = (_baseScale * details.scale)
//       .clamp(_minAvailableZoom, _maxAvailableZoom);
//
//   await controller!.setZoomLevel(_currentScale);
// }