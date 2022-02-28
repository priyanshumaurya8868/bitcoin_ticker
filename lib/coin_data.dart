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

const String url = "https://rest.coinapi.io/v1/exchangerate";

const API_KEY = "";

class CoinData {

 Future getCoinData(String selectedCurrency )async{
   Map<String,String> map = {};
   for(String crypto in cryptoList){
     String req_url = '$url/$crypto/$selectedCurrency?apikey=$API_KEY';
     http.Response response = await http.get(Uri.parse(req_url));
     if(response.statusCode ==200){
        var data = jsonDecode(response.body);
        double price = data["rate"];
        map[crypto] = price.toStringAsFixed(0);
      }else
        {
          print(response.reasonPhrase);
          print(response.statusCode);
          throw "Error is getting datat from  api";
        }
    }
   return map;
 }




}
