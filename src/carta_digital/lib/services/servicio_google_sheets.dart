import 'package:carta_digital/models/usuario_model.dart';
import 'package:gsheets/gsheets.dart';


class UserSheetApi{
                                            //Json con todas las credenciales
static const _credentials = r''' 
{
  "type": "service_account",
  "project_id": "cartadigital-139ba",
  "private_key_id": "f3b6dd521c928b6ce5f6073ff29d4f721738d0c1",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCnFlJMEwNcUO+d\nB4m98mDMLeJaMLt2Vu9/LUiypy1EuPp7Etxj4FuuvdQFHNltf7ZpNh+TAom00XBy\nVQw40FlIrtFpNavOkebBiPKd+XF/eptY+W1fSH8CuNR2CTmmXb5awfS79yv55IL4\n+9KnjmfhNflwkRS1q9R8Ii8N2Cvix/I+8TgBsZjaI0np05FHJJjoZ9irM7U+el+I\neTuarqLq+WiuLCamrcQ+kmJmCi05vn6/Bsz72nU79NA5RoiPC4zu6Kxc/OiDdGfR\nraTURX3kopCGwm+1MtDv+X4HpDq9FAbG+svV+pNIVkqAKszuhX8Jfr0R3TUSbHAK\nPwV4+xAtAgMBAAECggEABETd9Ba+fpH+XwwPXnAlWlIkdwyQJLNyl/EFzrOdb12e\n/EdZFi32abb7Bj5qrRFP1Hfkbi8hv8y5Nhm5SnCKGwETjmqZTWC4C3+bI02yQVZy\nm98hzc4XRDc0RnX/NmmfMI9Tn25EKLTIYv5jPXYLir6gvD2Ke3jnUnkOAWIajPHZ\nLxf34WTep0soqbDDZiqjqcSaSpaO+82lXpG2uOiVZFSLxkwxyGChEofceGVGJxc6\n5uY0CSEsGfQq5CCuvdeln2RBbXIP32rYz48TgGqBKDMTkkYy/EWe01ooGl6WivI1\nZpxJYz75G0Gt2ij0rjj5YZUD24VVLzLefOXzoMHBwQKBgQDPXpO+bF3R/7U2rqUI\nBPT5Y1EDsAblWOGd9ivPCuI3rKtBExxxsOn3IF97XQdVMukkJLMVKZy2wtLklPwy\nCmMi3F2LZzqxsiQ/SSdlt2nBWTvzVeOceC0NcEzmF8+tyI8cX5ADd2tJ8qUyxoP6\n+Dvp3Y9of2p/9iCYfxUJ3tKfhQKBgQDORWZdAY7iuLjCI7DmlL0ndWuOVdwV5cWy\nAxpdyhp7I8fNaNnyTIqalwpRx1fMhXvdjk0EmrYqlCKkAwJh4y8sFFzdojmJLyS0\nJD+EzgB+mlBlRAiGAnWTpkFZt22r4B8S+wRzb5gINDVbXBBAVfqvlj/VmCTMIdNz\nA4mTSw6KiQKBgA/sCxwL5ghBwgA42KMM/mJHpejKkzz43hnq1OJIy6XKtDuC5CQ2\nmUBIVAx80BtSlWQZDUcKsuW1f8vdRJ/y/DmpAeW6P191diMF0uiUdKJL37aHWbqh\n35Owk7b3DRMi2xoqnDwn5yz+XIDRjUCv3qnOQTycy+iXVVlgKJVhbnqhAoGBALoA\neMrbcdZeTjS6bHWwoFUpnABwyhJw7PGVvLvgWDq8TBqdNxM4FDBMjQCrai/CGqzx\n+d9yB1yj0gzlrctJSqtL/WXaOFnNSiKrISAHhwii7GY0kB8Prqii3gEh1+KKKls6\nQYw6j/St54NnpDvvjCuzqAJavKvawMrQ4MkSgJ1JAoGAKY7XhCCRPA/BjO9cqe8M\njrp6Ffh5OLdRUzHtMIDajd8+DEW/jjHhtzGe1UpeXdZTizWxeVNvahKqVZp4qGA/\n+nC4f6vRY6JUjOprCIA7McoRaLOO5w9gDg6vj+xMf7RO72TAw9VRaSKQW/mS1ijz\n9TGr2JMhXYBXbTxC4ACHvkY=\n-----END PRIVATE KEY-----\n",
  "client_email": "trabajo-ing-soft@cartadigital-139ba.iam.gserviceaccount.com",
  "client_id": "103227448224023809248",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/trabajo-ing-soft%40cartadigital-139ba.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';


final _spreedsheetId = '1FE2F6plcd5XHAVD4lYDMRFaTrfE9kJg5BMgI6JfxH9s';   //Id del la spreedsheet
final _gsheets = GSheets(_credentials); //Autenticacion 
Worksheet? _userSheet;    //Hoja de la spreedsheet en la que se esta trabajando
 
static final UserSheetApi _instance = UserSheetApi._internal();  //Declaro el campo estatico privado y utilizo un constructor privado



 static UserSheetApi getinstance(){ //devuelve la instancia
    return _instance;
 }

 UserSheetApi._internal(); //Nadie fuera de la clase puede generar nuevas instancias ya que este es su constructor privado




// Incializo los atributos clase
Future init () async {  
   if (_userSheet != null){ //Si tengo un usersheet lo devuelve
       return; 
}
      else {  
          try {
          final spreadsheet = await _gsheets.spreadsheet(_spreedsheetId);  //obtengo la spreedsheet
          _userSheet = await _getWorkSheet(spreadsheet , title: 'Usuarios'); //obtengo la hoja usuarios

          final primeraFila = ModeloUsuario.getDatos(); 
          await _userSheet!.values.insertRow(1, primeraFila); // en la primer fila pongo uid y mail 
 }
    catch(e){
      return null;
    }
}
}

// Metodo que te devuelve el worksheet que queres

Future<Worksheet> _getWorkSheet(  
  Spreadsheet spreadsheet, {
  required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);  //Crea y devuelve la hoja que necesitas a menos que surja un error
  } catch (e) {
      final sheet = await spreadsheet.worksheetByTitle(title);  // Busca una hoja con el nombre que queres
      if (sheet == null) { // chequea si la hoja no se encontro
          throw Exception('Worksheet $title no fue encontrada.');  
      }
    return sheet;
  }
}


 Future insert (List<Map<String, dynamic>> listaFila) async {
     await init(); //Espera que este incializado los valores de la instancia
        if (_userSheet == null ){ //Si la hoja es null retorna null
            return null;
      }
      final rows = listaFila.map((fila) => [
          fila[ModeloUsuario.nombre],
          fila[ModeloUsuario.correoelectronico],
] ).toList();

await _userSheet!.values.appendRows(rows); // Añade los valores a la fila 
}

//Devuelve en una lista de strings los valores contenidos en la primer columna
 Future<List<String>> getFirstColumn() async {
    await init();
  final column = await _userSheet!.values.column(1);
  
  return column.where((value) => value.isNotEmpty).toList();
}


 

}