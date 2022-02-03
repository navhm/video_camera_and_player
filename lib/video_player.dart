// import 'package:video_player/video_player.dart';
// import 'dart:io';
//
// ////////////////////////////////////////////////////////////////////////////////
// //Start Video PLayer
//
// Future<void> _startVideoPlayer() async {
//   if (videoFile == null) {
//     return;
//   }
//
//   final VideoPlayerController vController =
//       VideoPlayerController.file(File(videoFile!.path));
//   videoPlayerListener = () {
//     if (videoController != null && videoController!.value.size != null) {
//       // Refreshing the state to update video player with the correct ratio.
//       if (mounted) setState(() {});
//       videoController!.removeListener(videoPlayerListener!);
//     }
//   };
//   vController.addListener(videoPlayerListener!);
//   await vController.setLooping(true);
//   await vController.initialize();
//   await videoController?.dispose();
//   if (mounted) {
//     setState(() {
//       imageFile = null;
//       videoController = vController;
//     });
//   }
//   await vController.play();
// }
//
// ///////////////////////////////////////////////////////////////////////////////////////
// //Video Player Widget
//
// Widget _thumbnailWidget() {
//   final VideoPlayerController? localVideoController = videoController;
//
//   return Expanded(
//     child: Align(
//       alignment: Alignment.centerRight,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           localVideoController == null && imageFile == null
//               ? Container()
//               : SizedBox(
//                   child: (localVideoController == null)
//                       ? Image.file(File(imageFile!.path))
//                       : Container(
//                           child: Center(
//                             child: AspectRatio(
//                                 aspectRatio:
//                                     localVideoController.value.size != null
//                                         ? localVideoController.value.aspectRatio
//                                         : 1.0,
//                                 child: VideoPlayer(localVideoController)),
//                           ),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.pink)),
//                         ),
//                   width: 64.0,
//                   height: 64.0,
//                 ),
//         ],
//       ),
//     ),
//   );
// }
//
// ////////////////////////////////////////////////////////////////////////////////
