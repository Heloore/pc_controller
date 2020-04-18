abstract class Request {
  EHttpMethod method;
  String path;
  Map<String, String> body;
  Map<String, String> queryParams;
}

enum EHttpMethod { GET, POST }

class GetVolumeRequest extends Request {
  @override
  EHttpMethod method = EHttpMethod.GET;

  @override
  String path = "/get_current_volume";
}

class MuteVolumeRequest extends Request {
  @override
  EHttpMethod method = EHttpMethod.GET;

  @override
  String path = "/mute_volume";
}

class UnmuteVolumeRequest extends Request {
  @override
  EHttpMethod method = EHttpMethod.GET;

  @override
  String path = "/unmute_volume";

  @override
  Map<String, String> queryParams;
}

class SetVolumeRequest extends Request {
  @override
  EHttpMethod method = EHttpMethod.POST;

  @override
  String path = "/set_volume";

  SetVolumeRequest(int volume) {
    body = {"volume": volume.toString()};
  }
}

class MouseWhellRequest extends Request {
  @override
  EHttpMethod method = EHttpMethod.POST;

  @override
  String path = "/mouse_wheel";

  MouseWhellRequest(String direction, int offset) {
    body = {"direction": direction, "offset": offset.toString()};
  }
}

class MouseMovementRequest extends Request {
  @override
  EHttpMethod method = EHttpMethod.POST;

  @override
  String path = "/mouse";

  MouseMovementRequest(int x, int y) {
    body = {"x": x.toString(), "y": y.toString()};
  }
}

class KeyboardRequest extends Request {
  @override
  EHttpMethod method = EHttpMethod.POST;

  @override
  String path = "/keyboard";

  KeyboardRequest(String keyCode) {
    body = {"key": keyCode};
  }
}

class CMDRequest extends Request {
  @override
  EHttpMethod method = EHttpMethod.POST;

  @override
  String path = "/controller";

  CMDRequest(String command) {
    body = {"command": command};
  }
}
