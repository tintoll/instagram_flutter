import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CameraState extends ChangeNotifier {
  CameraController _controller;
  CameraDescription _cameraDescription;
  bool _readyTakePhoto = false;

  void dispose() {
    if(_controller != null) _controller.dispose();
    _controller = null;
    _cameraDescription = null;
    _readyTakePhoto = false;
    notifyListeners();
  }

  void getReadyToTakePhoto() async {
    List<CameraDescription> cameras = await availableCameras();

    if (cameras != null && cameras.isNotEmpty) {
      setDescription(cameras[0]);
    }

    bool init = false;
    while (!init) {
      init = await initailize();
    }

    _readyTakePhoto = true;
    notifyListeners();
  }

  void setDescription(CameraDescription cameraDescription) {
    _cameraDescription = cameraDescription;
    _controller = CameraController(_cameraDescription, ResolutionPreset.medium);
  }

  Future<bool> initailize() async {
    try {
      await _controller.initialize();
      return true;
    } catch (e) {
      return false;
    }
  }

  CameraController get controller => _controller;
  CameraDescription get cameraDescription => _cameraDescription;
  bool get isReadyToTakePhoto => _readyTakePhoto;
}
