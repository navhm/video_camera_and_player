// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:video_player/video_player.dart';
//
// List<CameraDescription> cameras = [];
//
// class VideoApp extends StatefulWidget {
//   @override
//   _VideoAppState createState() => _VideoAppState();
// }
//
// class _VideoAppState extends State<VideoApp>
//     with WidgetsBindingObserver, TickerProviderStateMixin {
//   CameraController? controller;
//   XFile? videoFile;
//   VideoPlayerController? videoController;
//   VoidCallback? videoPlayerListener;
//   bool enableAudio = true;
//   bool isLoading = false;
//   double _minAvailableExposureOffset = 0.0;
//   double _maxAvailableExposureOffset = 0.0;
//   double _minAvailableZoom = 1.0;
//   double _maxAvailableZoom = 1.0;
//   double _currentScale = 1.0;
//   double _baseScale = 1.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _ambiguate(WidgetsBinding.instance)?.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     _ambiguate(WidgetsBinding.instance)?.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final CameraController? cameraController = controller;
//
//     // App state changed before we got the chance to initialize.
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return;
//     }
//
//     if (state == AppLifecycleState.inactive) {
//       cameraController.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       onNewCameraSelected(cameraController.description);
//     }
//   }
//
//   @override
//   void onNewCameraSelected(CameraDescription cameraDescription) async {
//     final previousCameraController = controller;
//
//     final CameraController cameraController = CameraController(
//       cameraDescription,
//       ResolutionPreset.max,
//       enableAudio: enableAudio,
//       imageFormatGroup: ImageFormatGroup.jpeg,
//     );
//
//     controller = cameraController;
//
//     if (mounted) {
//       setState(() {});
//     }
//
//     // If the controller is updated then update the UI.
//     cameraController.addListener(() {
//       if (mounted) setState(() {});
//     });
//
//     try {
//       await cameraController.initialize();
//       await Future.wait([
//         cameraController
//             .getMinExposureOffset()
//             .then((value) => _minAvailableExposureOffset = value),
//         cameraController
//             .getMaxExposureOffset()
//             .then((value) => _maxAvailableExposureOffset = value),
//         cameraController
//             .getMaxZoomLevel()
//             .then((value) => _maxAvailableZoom = value),
//         cameraController
//             .getMinZoomLevel()
//             .then((value) => _minAvailableZoom = value),
//       ]);
//     } on CameraException catch (e) {}
//
//     if (mounted) {
//       setState(() {});
//     }
//
//     await previousCameraController?.dispose();
//   }
//
//   void onVideoRecordButtonPressed() {
//     startVideoRecording().then((_) {
//       if (mounted) setState(() {});
//     });
//   }
//
//   Future<void> startVideoRecording() async {
//     final CameraController? cameraController = controller;
//
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       showInSnackBar('Error: select a camera first.');
//       return;
//     }
//
//     if (cameraController.value.isRecordingVideo) {
//       // A recording is already started, do nothing.
//       return;
//     }
//
//     try {
//       await cameraController.startVideoRecording();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return;
//     }
//   }
//
//   void showInSnackBar(String message) {
//     // ignore: deprecated_member_use
//     _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   @override
//   // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       alignment: AlignmentDirectional.bottomCenter,
//       children: [
//         SizedBox(
//             height: double.infinity,
//             child: isLoading
//                 ? Container(
//                     color: Colors.black,
//                     height: double.infinity,
//                     width: double.infinity,
//                   )
//                 : CameraPreview(controller!)),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.black38,
//                 radius: 30,
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.photo,
//                       size: 30,
//                       color: Colors.white,
//                     )),
//               ),
//               CircleAvatar(
//                 backgroundColor: Colors.black38,
//                 radius: 30,
//                 child: IconButton(
//                     onPressed: () async {
//                       try {
//                         final image = await controller!.takePicture();
//                       } catch (e) {
//                         // If an error occurs, log the error to the console.
//                         print(e);
//                       }
//                     },
//                     icon: Icon(
//                       Icons.camera,
//                       size: 30,
//                       color: Colors.white,
//                     )),
//               ),
//               CircleAvatar(
//                 backgroundColor: Colors.black38,
//                 radius: 30,
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.flip_camera_android,
//                       size: 30,
//                       color: Colors.white,
//                     )),
//               ),
//             ],
//           ),
//         )
//       ],
//     ));
//   }
//
//   Widget _thumbnailWidget() {
//     final VideoPlayerController? localVideoController = videoController;
//
//     return Expanded(
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             localVideoController == null && imageFile == null
//                 ? Container()
//                 : SizedBox(
//                     child: (localVideoController == null)
//                         ? Image.file(File(imageFile!.path))
//                         : Container(
//                             child: Center(
//                               child: AspectRatio(
//                                   aspectRatio:
//                                       localVideoController.value.size != null
//                                           ? localVideoController
//                                               .value.aspectRatio
//                                           : 1.0,
//                                   child: VideoPlayer(localVideoController)),
//                             ),
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.pink)),
//                           ),
//                     width: 64.0,
//                     height: 64.0,
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// T? _ambiguate<T>(T? value) => value;
