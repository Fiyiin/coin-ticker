import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String _baseUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

  getCoinData(String crypto, String fiat) async {
    try {
      http.Response res = await http.get('$_baseUrl$crypto$fiat');

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return data['last'];
      } else
        print(res.body);
    } catch (e) {
      print(e);
    }
  }
}
