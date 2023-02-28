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
  String kvalMoney = 'NGN';
  // int currency = 0;

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
          print(selectedIndex);
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
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? $kvalMoney',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            // padding: const EdgeInsets.only(bottom: 20.0),
            color: Colors.lightBlue,
            child: getPicker()
          ),
        ],
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
