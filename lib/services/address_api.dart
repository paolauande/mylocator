import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:mylocator/models/address.dart';
import 'package:http/http.dart' as http;

class AddressAPI {
  static Future<AddressModel> getAddressByGeolocator() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    return geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position _currentPosition) =>
            AddressAPI.getAddressFromLatLng(_currentPosition));
  }

  static Future<AddressModel> getAddressFromLatLng(Position _currentPosition) {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    return geolocator
        .placemarkFromCoordinates(
            _currentPosition.latitude, _currentPosition.longitude)
        .then((List<Placemark> p) {
      Placemark place = p[0];
      String jsonAddress = '{"address":"' +
          place.thoroughfare +
          '","zipcode":"' +
          place.postalCode +
          '","city":"' +
          place.subAdministrativeArea +
          '","state":"' +
          place.administrativeArea +
          '", "neighborhood":"' +
          place.subLocality +
          '"}';
      AddressModel address = AddressModel.fromJson(jsonDecode(jsonAddress));
      print(address.toString());
      return address;
    }).catchError((error) {
      print(error);
      return null;
    });
  }

  static Future<AddressModel> fetchCep({String zipcode}) async {
    final response = await http.get('https://viacep.com.br/ws/$zipcode/json/');
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = json.decode(response.body);
      if (resp['erro'] == true) {
        throw Exception('Requisição inválida!');
      }
      return AddressModel.fromCEPJson(json.decode(response.body));
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}
