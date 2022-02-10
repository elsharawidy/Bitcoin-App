import 'package:http/http.dart' as http;
import 'dart:convert';
const apikey = '1C2AD0DE-28F8-48F1-BB07-B6EC5DA74FC5';
class Network {


  Future getInfo(String currency,String cryptolist)async{
    http.Response response = await http.get(
        'https://rest.coinapi.io/v1/exchangerate/$cryptolist/$currency?apikey=$apikey#');
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

}