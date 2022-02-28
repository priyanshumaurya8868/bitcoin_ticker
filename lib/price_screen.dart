import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}


class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'INR';
  bool isWaiting = false;

  CoinData _coinData = CoinData();
  List<CryptoCard> list=[];

  @override
  void initState() {
    super.initState();
   getEntries(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
           Column(
             children: list,
           ),
          Visibility(
            visible: isWaiting,
            child: SpinKitDoubleBounce(
            color: Colors.lightBlueAccent,
            size: 100.0,),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? getIOSCupertinoPicker() : getAndroidDropdown(),
          ),
        ],
      ),
    );
  }

  Widget getIOSCupertinoPicker() {
    List<Widget> list = [];
    for (String currency in currenciesList) {
      var item = Text(currency,style: TextStyle(color: Colors.white),);
      list.add(item);
    }

    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedCurrency = currenciesList[index];
            getEntries(selectedCurrency);
          });
        },
        children: list
    );
  }

  DropdownButton<String> getAndroidDropdown() {
    List<DropdownMenuItem<String>> list = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      list.add(item);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: list,
      elevation: 16,
      onChanged: (selectedValue) {
        print(selectedValue);
        setState(() {
          selectedCurrency = selectedValue!;
          getEntries(selectedCurrency);
        });
      },
    );
  }

   getEntries(String currency) async {
    setState(() {
      isWaiting = true;
    });
    List<CryptoCard> temp = [];
   var res = await _coinData.getCoinData(currency);
   for(String crypto in cryptoList){
     temp.add(CryptoCard(cryto: crypto, currency: res[crypto],selectedCurrency: currency,),);
   }
   setState(() {
     isWaiting = false;
     list = temp ;

   });
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
    required this.cryto,
    required this.currency,
    required this.selectedCurrency
  }) : super(key: key);

  final String cryto ;
  final String currency;
  final String selectedCurrency;


  @override
  Widget build(BuildContext context) {
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
            '1 $cryto = $selectedCurrency $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
