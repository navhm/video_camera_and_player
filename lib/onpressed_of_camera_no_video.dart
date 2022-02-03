cameraController != null &&
cameraController.value.isInitialized &&
!cameraController.value.isRecordingVideo
? onTakePictureButtonPressed
    : null,

void onTakePictureButtonPressed() {
  takePicture().then((XFile? file) {
    if (mounted) {
      setState(() {
        imageFile = file;
        videoController?.dispose();
        videoController = null;
      });
      if (file != null) showInSnackBar('Picture saved to ${file.path}');
    }
  });
}

Future<XFile?> takePicture() async {
  final CameraController? cameraController = controller;
  if (cameraController == null || !cameraController.value.isInitialized) {
    showInSnackBar('Error: select a camera first.');
    return null;
  }

  if (cameraController.value.isTakingPicture) {
    // A capture is already pending, do nothing.
    return null;
  }

  try {
    XFile file = await cameraController.takePicture();
    return file;
  } on CameraException catch (e) {
    _showCameraException(e);
    return null;
  }
}





///////////////////////////////////////////////////////

void _showCameraException(CameraException e) {
  logError(e.code, e.description);
  showInSnackBar('Error: ${e.code}\n${e.description}');
}

void logError(String code, String? message) {
  if (message != null) {
    print('Error: $code\nError Message: $message');
  } else {
    print('Error: $code');
  }
}

void showInSnackBar(String message) {
  // ignore: deprecated_member_use
  _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
}