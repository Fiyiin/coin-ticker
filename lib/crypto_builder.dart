import 'package:flutter/material.dart';

import 'coin_data.dart';

class CryptoBuilder {
  Future<dynamic> prices(crypto, fiat) async {
    return await CoinData().getCoinData(crypto, fiat);
  }

  Future<List<Map<String, Map>>> rates(String selectedCurrency) async {
    print('$selectedCurrency....');
    return Stream.fromIterable(cryptoList).asyncMap(<String, Map> (String crypto) async {
      var price = await prices(crypto, selectedCurrency);
      // return price;jsssssssssssssssss
      Map<String, Map> res = { 'value': { 'crypto': crypto, 'price': price } };
      return Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $crypto = $price $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
