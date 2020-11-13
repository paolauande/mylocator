import 'package:flutter/material.dart';
import 'package:mylocator/screens/AddAddress.dart';
import 'package:mylocator/widgets/components.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: appBar("Busque seu endereço por"),
      body: addressOptions(),
    );
  }

  addressOptions() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          myBtn("CEP", () => searchByCEP(context)),
          SizedBox(
            height: 50,
          ),
          myBtn("Localização atual", () => searchByLocation(context))
        ],
      ),
    );
  }

  searchByLocation(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => new AddAddress(false, null),
    );
    setState(() {});
  }

  searchByCEP(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => new AddAddress(true, null),
    );
    setState(() {});
  }
}
