import 'package:geolocator/geolocator.dart';

class AddressModel {
  int id;
  String zipcode;
  String address;
  String complement;
  String neighborhood;
  String number;
  String city;
  String state;
  String unity;
  String ibge;
  String gia;
  bool confirmed;
  bool active;
  String timestamp;
  bool softDeletes;
  Position position;

  AddressModel({
    this.id,
    this.zipcode,
    this.address,
    this.complement,
    this.neighborhood,
    this.number,
    this.city,
    this.state,
    this.unity,
    this.position,
    this.ibge,
    this.gia,
    this.confirmed,
    this.active,
    this.timestamp,
    this.softDeletes,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zipcode = json['zipcode'];
    address = json['address'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    number = json['number'];
    city = json['city'];
    state = json['state'];
    unity = json['unity'];
    ibge = json['ibge'];
    gia = json['gia'];
    confirmed = json['confirmed'] == 1
        ? true
        : json['confirmed'] == 0
            ? false
            : json['confirmed'];
    active = json['active'] == 1
        ? true
        : json['active'] == 0
            ? false
            : json['active'];
    timestamp = json['timestamp'];
    softDeletes = json['softDeletes'] == 1
        ? true
        : json['softDeletes'] == 0
            ? false
            : json['softDeletes'];
  }

  AddressModel.fromCEPJson(Map<String, dynamic> parsedJson) {
    zipcode = parsedJson['cep'];
    address = parsedJson['logradouro'];
    neighborhood = parsedJson['bairro'];
    city = parsedJson['localidade'];
    state = parsedJson['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['zipcode'] = this.zipcode;
    data['address'] = this.address;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['number'] = this.number;
    data['city'] = this.city;
    data['state'] = this.state;
    data['unity'] = this.unity;
    data['ibge'] = "ibge";
    data['gia'] = "gia";
    data['confirmed'] = false;
    data['active'] = true;
    // data['timestamp'] = this.timestamp;
    // data['softDeletes'] = this.softDeletes;
    return data;
  }
}
