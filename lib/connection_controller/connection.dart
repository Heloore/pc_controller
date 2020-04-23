import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pc_controll/dto/requests/request.dart';

class ConnectionController {
  String pcAddress = "";
  static final ConnectionController _controller = ConnectionController._();

  factory ConnectionController() => _controller;
  ConnectionController._();

  Future<void> setApiPath(String address) async {
    assert(address != null && address.isNotEmpty);
    if (await _checkAddress(address)) {
      pcAddress = address;
    } else {
      throw ArgumentError("Can't establish connection");
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

  Future<bool> _checkAddress(String address) async {
    var resp = await http.get("http://" + address + "/check_connection");
    if (resp.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }
}
