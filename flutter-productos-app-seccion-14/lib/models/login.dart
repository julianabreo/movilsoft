// To parse this JSON data, do
//
//     final login = loginFromMap(jsonString);

import 'dart:convert';

class Login {
  int coderror;
  String nomerror;
  String? token;
  String? usuario;
  int? idusuario;
  int? identifiusuario;
  String? nombreusuario;

  Login({
    required this.coderror,
    required this.nomerror,
    this.token,
    this.usuario,
    this.idusuario,
    this.identifiusuario,
    this.nombreusuario,
  });

  factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        coderror: json["coderror"],
        nomerror: json["nomerror"],
        token: json["token"],
        usuario: json["usuario"],
        idusuario: json["idusuario"],
        identifiusuario: json["identifiusuario"],
        nombreusuario: json["nombreusuario"],
      );

  Map<String, dynamic> toMap() => {
        "coderror": coderror,
        "nomerror": nomerror,
        "token": token,
        "usuario": usuario,
        "idusuario": idusuario,
        "identifiusuario": identifiusuario,
        "nombreusuario": nombreusuario,
      };
}
