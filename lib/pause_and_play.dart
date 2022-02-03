// cameraController != null &&
// cameraController.value.isInitialized &&
// cameraController.value.isRecordingVideo
// ? (cameraController.value.isRecordingPaused)
// ? onResumeButtonPressed
//     : onPauseButtonPressed
//     : null,

void onResumeButtonPressed() {
  resumeVideoRecording().then((_) {
    if (mounted) setState(() {});
    showInSnackBar('Video recording resumed');
  });
}

void onPauseButtonPressed() {
  pauseVideoRecording().then((_) {
    if (mounted) setState(() {});
    showInSnackBar('Video recording paused');
  });
}

Future<void> pauseVideoRecording() async {
  final CameraController? cameraController = controller;

  if (cameraController == null || !cameraController.value.isRecordingVideo) {
    return null;
  }

  try {
    await cameraController.pauseVideoRecording();
  } on CameraException catch (e) {
    _showCameraException(e);
    rethrow;
  }
}

Future<void> resumeVideoRecording() async {
  final CameraController? cameraController = controller;

  if (cameraController == null || !cameraController.value.isRecordingVideo) {
    return null;
  }

  try {
    await cameraController.resumeVideoRecording();
  } on CameraException catch (e) {
    _showCameraException(e);
    rethrow;
  }
}
