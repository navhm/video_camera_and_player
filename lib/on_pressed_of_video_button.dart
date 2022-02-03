onPressed
cameraController != null &&
cameraController.value.isInitialized &&
!cameraController.value.isRecordingVideo
? onVideoRecordButtonPressed
    : null,

void onVideoRecordButtonPressed() {
  startVideoRecording().then((_) {
    if (mounted) setState(() {});
  });
}

Future<void> startVideoRecording() async {
  final CameraController? cameraController = controller;

  if (cameraController == null || !cameraController.value.isInitialized) {
    showInSnackBar('Error: select a camera first.');
    return;
  }

  if (cameraController.value.isRecordingVideo) {
    // A recording is already started, do nothing.
    return;
  }

  try {
    await cameraController.startVideoRecording();
  } on CameraException catch (e) {
    _showCameraException(e);
    return;
  }
}
