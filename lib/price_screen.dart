import 'package:bitcoin_ticker/crypto_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

String selectedCurrency;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCrypto = 'BTC';

  List<Map<String, Map>> children = [];

  void onChange(List<Map<String, Map>> children) {
    setState(() {
      this.children = children;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('$selectedCurrency...*');

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: this.children.map((Map<String, Map> child) {
              return Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ${child['value']['crypto']} = ${child['value']['price']} $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          Picker(newCurrency: onChange),
        ],
      ),
    );
  }
}

class Picker extends StatefulWidget {
  Picker({this.newCurrency});

  final Function newCurrency;

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  newCurrency(value) async {
    setState(() {
      selectedCurrency = value;
      print('$selectedCurrency....+');
    });
    var children = await CryptoBuilder().rates(selectedCurrency);
    widget.newCurrency(children);
  }

  Widget androidDropdown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          child: Text(value),
          value: value,
        );
      }).toList(),
      onChanged: newCurrency,
    );
  }

  Widget iosPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
      },
      children: currenciesList.map((String value) {
        return Text(value);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 30.0),
      color: Colors.lightBlue,
      child: Platform.isIOS ? iosPicker() : androidDropdown(),
    );
  }
}
