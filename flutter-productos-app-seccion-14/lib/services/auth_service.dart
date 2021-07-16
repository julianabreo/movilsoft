import 'dart:convert';
import 'package:productos_app/models/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final storage = new FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    final url = Uri.parse('http://movisoft.ceintemovil.com/wsceinte/token');
    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{'usuario': email, 'contrasena': password},
        ));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    Login dataresp = Login.fromJson(resp.body);

    if (dataresp.token != null) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return dataresp.nomerror;
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
