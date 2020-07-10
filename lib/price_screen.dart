import 'package:coin_ticker/crypto_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedCrypto = 'BTC';
  double price;

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

  Widget androidDropdown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          child: Text(value),
          value: value,
        );
      }).toList(),
      onChanged: (value) async {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CryptoBuilder.rates(selectedCurrency),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = snapshot.data;
        } else {
          children = <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Center(
                child: SizedBox(
                  width: 60,
                  child: CircularProgressIndicator(),
                  height: 60,
                ),
              ),
            ),
          ];
        }
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
                children: children,
              ),
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: Platform.isIOS ? iosPicker() : androidDropdown(),
              ),
            ],
          ),
        );
      },
    );
  }
}
