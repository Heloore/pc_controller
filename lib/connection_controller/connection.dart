import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pc_controll/connection_controller/request.dart';

class ConnectionController {
  static String pcAddress = "";
  static final ConnectionController _controller = ConnectionController._();

  factory ConnectionController() => _controller;
  ConnectionController._();

  Future<void> setApiPath(String ip) async {
    if (await _chechAddress(ip)) {
      pcAddress = ip;
    } else {
      throw ArgumentError("Invalid address");
    }
  }

  Future<http.Response> makeRequest(Request request) async {
    http.Response response;
    switch (request.method) {
      case EHttpMethod.GET:
        response = await _doGetRequest(request.path, request.queryParams);
        break;
      case EHttpMethod.POST:
        response = await _doPostRequest(request.path, request.body);
        break;
    }

    return response;
  }

  Future<http.Response> _doGetRequest(String path, Map<String, String> queryParams) async {
    return await http.get(pcAddress + path);
  }

  Future<http.Response> _doPostRequest(String path, Map<String, String> body) async {
    return await http.post(pcAddress + path, body: body);
  }

  Future<bool> _chechAddress(String address) async {
    var addr = "http://" + address + "/check_connection";
    print(addr);
    var resp = await http.get(addr);
    print(resp.statusCode);
    if (resp.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }
}
