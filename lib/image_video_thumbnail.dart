// import 'package:flutter/material.dart';
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
//             child: (localVideoController == null)
//                 ? Image.file(File(imageFile!.path))
//                 : Container(
//               child: Center(
//                 child: AspectRatio(
//                     aspectRatio:
//                     localVideoController.value.size != null
//                         ? localVideoController
//                         .value.aspectRatio
//                         : 1.0,
//                     child: VideoPlayer(localVideoController)),
//               ),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.pink)),
//             ),
//             width: 64.0,
//             height: 64.0,
//           ),
//         ],
//       ),
//     ),
//   );
// }