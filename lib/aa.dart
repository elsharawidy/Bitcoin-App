










import 'package:bitcoin_ticker/network.dart';
import 'package:bitcoin_ticker/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  double value1;
  double value2;
  double value0;


  dynamic getDataBTC() async {

    Network net = Network();
    var data = await net.getInfo(selectedCurrency, cryptoList[0]);
    setState(() {
      if (data != null) {
        value0 = data['rate'];
      } else {
        print('No data Input');
      }
    });
  }
  dynamic getDataETH() async {

    Network net = Network();
    var data = await net.getInfo(selectedCurrency, cryptoList[1]);
    setState(() {
      if (data != null) {
        value1 = data['rate'];
      } else {
        print('No data Input');
      }
    });
  }
  dynamic getDataLTC() async {

    Network net = Network();
    var data = await net.getInfo(selectedCurrency, cryptoList[2]);
    setState(() {
      if (data != null) {
        value2 = data['rate'];
      } else {
        print('No data Input');
      }
    });
  }



  List<Widget> getCupertinoPickerItems() {
    List<Widget> iosItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var item = Text(currenciesList[i]);
      iosItems.add(item);
    }
    return iosItems;
  }

  List<DropdownMenuItem> getDropDownButtonItems() {
    List<DropdownMenuItem<String>> androidItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      DropdownMenuItem<String> item = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      androidItems.add(item);
    }
    return androidItems;
  }

  @override
  void initState() {
    getDataBTC();
    getDataETH();
    getDataLTC();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('😞 Coin Ticker'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ReusableCard(
            coin: cryptoList[0],
            value: value0,
            selectedCurrency: selectedCurrency,
          ),
          ReusableCard(
            coin: cryptoList[1],
            value: value1,
            selectedCurrency: selectedCurrency,
          ),
          ReusableCard(
            coin: cryptoList[2],
            value: value2,
            selectedCurrency: selectedCurrency,
          ),
          Expanded(
            flex: 5,
            child: Container(),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS
                  ? CupertinoPicker(
                backgroundColor: Colors.lightBlue,
                itemExtent: 32.0,
                children: getCupertinoPickerItems(),
                onSelectedItemChanged: (newValue) {
                  setState(() {
                    selectedCurrency = currenciesList[newValue];
                    getDataBTC();
                    getDataETH();
                    getDataLTC();
                  });
                },
              )
                  : DropdownButton<String>(
                value: selectedCurrency,
                items: getDropDownButtonItems(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCurrency = newValue;
                  });
                },
              )),
        ],
      ),
    );
  }
}
