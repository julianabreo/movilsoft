import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:background_location/background_location.dart';
import 'package:movisoft_app/screens/screens.dart';
import 'package:movisoft_app/services/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(AppState());
final storage = new FlutterSecureStorage();

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movilidad App',
      initialRoute: 'login',
      routes: {
        'checking': (_) => CheckAuthScreen(),
        'home': (_) => HomeScreen(),
        'login': (_) => LoginScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.indigo),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0)),
    );
  }

  static startServiceGps() async {
    await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService(distanceFilter: 20);
    BackgroundLocation.getLocationUpdates((location) {
      String latitude = "";
      String longitude = "";
      latitude = location.latitude.toString();
      longitude = location.longitude.toString();
      sendLocation(
          latitude,
          longitude,
          DateTime.fromMillisecondsSinceEpoch(location.time!.toInt(),
                  isUtc: true)
              .toIso8601String());
      //accuracy = location.accuracy.toString();
      //altitude = location.altitude.toString();
      //bearing = location.bearing.toString();
      //speed = location.speed.toString();
      //time = DateTime.fromMillisecondsSinceEpoch(location.time!.toInt()).toString();
    });
  }

  static Future<String> readTokenM(String nameKey) async {
    return await storage.read(key: nameKey) ?? '';
  }

  static sendLocation(String lat, String log, String date) async {
    final url =
        Uri.parse('http://movisoft.ceintemovil.com/wsceinte/api/location');
    String idusuario = await readTokenM('iduser');
    String token = await readTokenM('token');
    try {
      final resp = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(
            <String, String>{
              'idgrupohorario': '1',
              'idusuario': idusuario,
              'loclat': lat,
              'loclng': log,
              'usuariocrea': idusuario,
              'fecharegistro': date
            },
          ));
    } catch (ex) {
      print(ex.toString());
    }
  }

  static stopServiceGps() async {
    BackgroundLocation.stopLocationService();
  }
}
