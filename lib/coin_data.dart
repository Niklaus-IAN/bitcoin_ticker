import 'package:flutter/material.dart';
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
  'NGN',
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
  Future<dynamic> getCoinData(String coinprice) async {
    //4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    //5: Return a Map of the results instead of a single value.
    Map<String, String> cryptoPrices = {};
    // String? coin;
    for (String crypto in cryptoList) {
      Uri url = Uri.https(
          'rest.coinapi.io',
          '/v1/exchangerate/$crypto/$coinprice',
          {'apikey': '5B14B834-A1D9-49DB-88C3-FBCAFA74DD13'});
      // api.openweathermap.org/data/2.5/weather?q=London&appid={55d7f49802a9cc4dfa0e0f4dcc5603ac}
      // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        // print(response.statusCode);
        // print(response.body);
        var data = response.body;
        print(data);
        // return jsonDecode(data);
        // var longitude = jsonDecode(data)['coord']['lon'];
        // print(longitude);
        double datum = jsonDecode(data)['rate'];
        //Create a new key value pair, with the key being the crypto symbol and the value being the lastPrice of that crypto currency.
        cryptoPrices[crypto] = datum.toStringAsFixed(0);
        // print(moneys);

        // var weatherReport = jsonDecode(data)['weather'][0]['id'];
        // var cityName = jsonDecode(data)['name'];
        // var temperature = jsonDecode(data)['main']['temp'];
        //
        // print(weatherReport);
        // print(cityName);
        // print(temperature);
      } else {
        print(response.statusCode);
        // Throwing an error
        throw 'Problem with the get request';
      }
      return cryptoPrices;
    }
  }

  // Future<http.Response> fetchAlbum() {
  //   return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  // }
}
