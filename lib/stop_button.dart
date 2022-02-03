cameraController != null &&
cameraController.value.isInitialized &&
cameraController.value.isRecordingVideo
? onStopButtonPressed
    : null,

void onStopButtonPressed() {
  stopVideoRecording().then((file) {
    if (mounted) setState(() {});
    if (file != null) {
      showInSnackBar('Video recorded to ${file.path}');
      videoFile = file;
      _startVideoPlayer();
    }
  });
}

Future<XFile?> stopVideoRecording() async {
  final CameraController? cameraController = controller;

  if (cameraController == null || !cameraController.value.isRecordingVideo) {
    return null;
  }

  try {
    return cameraController.stopVideoRecording();
  } on CameraException catch (e) {
    _showCameraException(e);
    return null;
  }
}

Future<void> _startVideoPlayer() async {
  if (videoFile == null) {
    return;
  }
  final VideoPlayerController vController =
  VideoPlayerController.file(File(videoFile!.path));
  videoPlayerListener = () {
    if (videoController != null && videoController!.value.size != null) {
      // Refreshing the state to update video player with the correct ratio.
      if (mounted) setState(() {});
      videoController!.removeListener(videoPlayerListener!);
    }
  };
  vController.addListener(videoPlayerListener!);
  await vController.setLooping(true);
  await vController.initialize();
  await videoController?.dispose();
  if (mounted) {
    setState(() {
      imageFile = null;
      videoController = vController;
    });
  }
  await vController.play();
}
