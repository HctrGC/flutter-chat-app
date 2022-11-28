import 'dart:convert';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/global/environment.dart';


class AuthService with ChangeNotifier {

  Usuario usuario = Usuario();

  final _storage = FlutterSecureStorage();

  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  bool _autenticando = false;
  bool get autenticando => _autenticando;
  set autenticando(bool aut){
    _autenticando = aut;
    notifyListeners(); 
  } 

  bool _registrando = false;
  bool get registrando => _registrando;
  set registrando(bool aut){
    _registrando = aut;
    notifyListeners(); 
  } 
    

  Future<bool> login(String email, String pwd) async {

    autenticando = true;

    final data = {
      'email': email,
      'password': pwd
    };

    final uri = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(uri,
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    
    autenticando = false;

    if (resp.statusCode == 200) {
      final response = loginResponseFromJson(resp.body);
      usuario = response.usuario!;
      await _guardarToken(response.token!);
      
      return true;
    }
    
    return false;
  }

  Future<String> register(String email, String pwd, String name) async {

    registrando = true;

    final data = {
      'email': email,
      'password': pwd,
      'nombre': name
    };

    final uri = Uri.parse('${Environment.apiUrl}/login/new');

    final resp = await http.post(uri,
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    registrando = false;

    if (resp.statusCode == 200) {
      final response = loginResponseFromJson(resp.body);
      usuario = response.usuario!;
      await _guardarToken(response.token!);
      
      return "true";

    } else {

      final respBody = jsonDecode(resp.body);
      return respBody['msg'];

    }
  }

  Future<bool> isLogged() async {
    final token = await _storage.read(key: 'token');
    if (token != null) {
      final uri = Uri.parse('${Environment.apiUrl}/login/renew');
      try {
        final resp = await http.get(uri,
          headers: {
            'Content-Type': 'application/json',
            'x-token': token
          }
        );

        if (resp.statusCode == 200) {
          final response = loginResponseFromJson(resp.body);
          usuario = response.usuario!;
          await _guardarToken(response.token!);
          
          return true;
        } else {

          logout();
          return false;

        }
      } catch(e) {
        return false;
      }
    }
    return false;
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

}