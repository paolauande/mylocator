import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mylocator/models/address.dart';
import 'package:mylocator/services/address_api.dart';
import 'package:mylocator/widgets/components.dart';
import 'package:mylocator/widgets/styles.dart';

class AddAddress extends StatefulWidget {
  bool isCEP;
  AddressModel addressModel;
  AddAddress(this.isCEP, this.addressModel);
  @override
  _AddAddressState createState() => _AddAddressState(isCEP, addressModel);
}

class _AddAddressState extends State<AddAddress> {
  bool isCEP;
  AddressModel addressModel;
  TextEditingController _searchCepController = TextEditingController();
  _AddAddressState(this.isCEP, this.addressModel);
  final _formKey = GlobalKey<FormState>();
  int addressId;
  int userId;
  bool viewVisible = false;
  bool isLoading = false;
  var maskTextInputFormatter = MaskTextInputFormatter(
      mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});
  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: appBar(isCEP ? "Pelo CEP" : "Pela localização atual"),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: isCEP
                  ? <Widget>[
                      _buildSearchCepTextField(),
                      _buildSearchCepButton(),
                      _buildResultForm(),
                    ]
                  : <Widget>[
                      _buildSearchButton(),
                      _buildResultForm(),
                    ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchCepTextField() {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: [maskTextInputFormatter],
      maxLength: 9,
      style: hightlightText,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: 'Digite o CEP para buscar um endereço',
          hintStyle: disabledText),
      controller: _searchCepController,
      enabled: true,
    );
  }

  Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        onTap: _searchCep,
        child: Container(
          width: 100,
          height: 50,
          child: isLoading
              ? _circularLoading()
              : Center(
                  child: Text(
                    'Pronto',
                    style: whiteText,
                  ),
                ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [highlightColor, defaultColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  _searchCep() async {
    String zipcode = _searchCepController.text;
    if (zipcode.isEmpty) {
      return;
    }
    setState(() {
      isLoading = true;
      addressModel = null;
    });

    zipcode = zipcode.replaceAll("-", "");
    await AddressAPI.fetchCep(zipcode: zipcode).then((onValue) {
      setState(() {
        addressModel = onValue;
        isLoading = false;
        viewVisible = true;
      });
    }).catchError((onError) {
      setState(() {
        isLoading = false;
        viewVisible = true;
      });
    });
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        onTap: _searchLocation,
        child: Container(
          width: 100,
          height: 50,
          child: isLoading
              ? _circularLoading()
              : Center(
                  child: Text(
                    'Localizar-me',
                    style: whiteText,
                  ),
                ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [highlightColor, defaultColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: Center(
        child: Text(
          "Aguarde...",
          style: whiteText,
        ),
      ),
    );
  }

  _searchLocation() async {
    setState(() {
      isLoading = true;
      addressModel = null;
    });

    await AddressAPI.getAddressByGeolocator().then((onValue) {
      setState(() {
        addressModel = onValue;
        isLoading = false;
        viewVisible = true;
      });
    }).catchError((onError) {
      setState(() {
        isLoading = false;
        viewVisible = true;
      });
    });
  }

  Widget _buildResultForm() {
    return Visibility(
      visible: viewVisible,
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: _buildAddressFields(),
      ),
    );
  }

  Widget _buildAddressFields() {
    return new Column(
        children: addressModel == null
            ? <Widget>[_buildWidget()]
            : <Widget>[
                addressField(addressModel.zipcode),
                addressField(addressModel.address),
                addressField(addressModel.neighborhood),
                addressField(addressModel.city),
                addressField(addressModel.state),
              ]);
  }

  Widget _buildWidget() {
    return Container(
      child: Text(
        "Localização não encontrada. Tente novamente.",
        style: alertText,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget addressField(String inputBoxName) {
    var field = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        style: hightlightText,
        readOnly: true,
        decoration: new InputDecoration(
            hintText: inputBoxName, hintStyle: hightlightText),
      ),
    );
    return field;
  }
}
