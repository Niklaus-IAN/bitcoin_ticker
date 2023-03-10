// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform; // you can "show","hide" or "as" a library

// const double _kItemExtent = 32.0;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String kvalMoney = 'USD';
  // String currency = '?';

  // String coins = 'BTC';

  CoinData btcData = CoinData();

  // late String money;

  //value had to be updated into a Map to store the values of all three cryptocurrencies.
  Map<String, String> coinValues = {};

  //7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
  bool isWaiting = false;

  void btcdatas() async {
    isWaiting = true;
    try {
      var data = await btcData.getCoinData(kvalMoney);
      //13. We can't await in a setState(). So you have to separate it out into two steps.

      //7: Second, we set it to true when we initiate the request for prices.
      print(data);
      isWaiting = false;
      setState(() {
        coinValues = data;
        // toStringAsFixed rounds up the value also makes it a string
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //14. Call btcdatas() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    btcdatas();
  }

  // String monies = btcdatas();
  // print(btcdatas())

  // btcTest() {
  //   var btcAsk = btcData.getCoinData();
  // }

  Row andriodDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      String currencies = currency;
      var newItem = DropdownMenuItem(
        value: currencies,
        child: Text(currencies),
      );
      dropdownItems.add(newItem);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Currency:',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        const SizedBox(
          width: 15,
        ),
        DropdownButton<String>(
          value: kvalMoney,
          items: dropdownItems,
          onChanged: (value) {
            setState(() {
              kvalMoney = value.toString();
              btcdatas();
            });
            // kvalMoney = value;
          },
        ),
      ],
    );
  }

  // List<DropdownMenuItem<String>> getDropdownCurrency() {
  //
  // }

  CupertinoPicker iOSPicker() {
    List<Widget> cupertinoDropdown = [];
    for (String money in currenciesList) {
      Widget moneyList = Text(money);
      cupertinoDropdown.add(moneyList);
    }
    return CupertinoPicker(
        // IOS Selection
        backgroundColor: Colors.lightBlue,
        magnification: 1.0,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            kvalMoney = currenciesList[selectedIndex].toString();
            btcdatas();
          });
        },
        children: cupertinoDropdown);
  }

  Widget getPicker() {
    if (!kIsWeb && Platform.isIOS) {
      return iOSPicker();
    } else {
      return andriodDropdown();
    }
  }

//   onPressed: () async {
//   var weatherDatum = await weather.getLocationWeather();
//   locateWeather(weatherDatum);
// },

  List<Widget> cryptoInfos() {
    List<Widget> buildedCard = [];
    for (String coins in cryptoList) {
      buildedCard.add(
        BuildCard(
          money: coins,
          //7. Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
          currency: isWaiting ? '?' : coinValues[coins],
          kvalMoney: kvalMoney,
        ),
      );
    }
    return buildedCard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: cryptoInfos(),
            ),
          ),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            // padding: const EdgeInsets.only(bottom: 20.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }

//   Card BuildCard(String money) {
//     return Card(
//       color: Colors.lightBlueAccent,
//       elevation: 5.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//         child: Text(
//           '1 $money = $currency $kvalMoney',
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontSize: 20.0,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

}

class BuildCard extends StatelessWidget {
  // const BuildCard({Key? key}) : super(key: key);
  const BuildCard({
    this.money,
    this.kvalMoney,
    this.currency,
  });

  final String? money;
  final String? kvalMoney;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $money = $currency $kvalMoney',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

//Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// const Text(
// 'Currency:',
// style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
// ),
// const SizedBox(
// width: 15,
// ),
// DropdownButton<String>(
// value: kvalMoney,
// items: getDropdownCurrency(),
// onChanged: (value) {
// setState(() {
// kvalMoney = value.toString();
// });
// // kvalMoney = value;
// },
// ),
// ],
// ),
