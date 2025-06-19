import 'package:carta_digital/models/usuario_model.dart';
import 'package:gsheets/gsheets.dart';


class UserSheetApi{
                                            //Json con todas las credenciales
static const _credentials = r''' 
{
  "type": "service_account",
  "project_id": "cartadigital-139ba",
  "private_key_id": "450b81e6ed9dc99a0806c8c7ee5ceef1d8d8cb17",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC7iO94AHO7DUcW\nxcHEXPc8FZbgV4Vh5xAzCiqOJsVmg1TUSS5OS68h8G67pP5YXr5ScWKxNhGF3MOK\nvDAC4TjpPshDuscW2XLzKmN+1KMkmdhddDHAGCEqou0hERPuHUlCSHhKLfYJqf8r\nOa+pRD10lP6+CPmZRuz36m8izWX2Z/XkQWM4KSgps4mo2+eSB6tu+Yk2uQ3Jk341\no7sXDRjge04oFWB6/B/VgP6wbahO5YqJfqT1VaG3TWi6Sesf6oqi21uh910mh30k\nXEAE1r3TNRvi0Dt3Yno6TNAsKrIASrHLdjyMsVRYW+AHIlyK8MX4oCZ9vYlIMd6P\n2FGPyP1HAgMBAAECggEAA3MV4JG1j0PDwn35vfhtzcuh3leNywq6iA3QUZQR/nw8\n87iy4trOimPHTalPymVXv+F5DMRvVxSD/knO4katStEOUvydC+UNEb7+XIdhxtsT\nmUh5X8yx03xyuzB6ut8MCW2W1Np6k5vuZyek/QqVzM6uzuUQXkrpMfg8ehnoHbus\nv5DnSvfM0LAuN4vVvjHCpsaz/MkN2KKEVDB7PEkjb+KWV4657eLbmgPUpJq40W0x\notyBKfcqMzsucIR3rJYsmo/7ptFqIaOVwFa9f++jrz+8GVfWZ4fZeltb5bJZzKqh\n2gm24sNJKMcW6gSA+eY3VR3jTg/p4AEZ8zHLUlcaYQKBgQDj5APzX2iu3P2K6Gov\nYSa2XUVnBurjHhkC82JGJ+VsxOL70oUQPhuN3V9KXwRQMh+Ohedn9XiKCxyRXpdW\naedByQ7TANAat6sKgaTRV/Korwa8nLi+ggEWCv4+aRHD+jd5ayayaJaSp5Hcrd5x\nG52ncNfajfYeDFYozEnLHD3WpwKBgQDSqqBtODAddNkN/lYNIPN3IcSJE98Fd3qz\nmLn8roSjgJEoyX9vAZFczNMY/Y7XmmG8uBEgp+B0fvu3CYi0jbJVwSWSwkR4QUOS\nZk1JXmT1oSwRiJLsQ15qnjGHPQuoeN7Db5YqXxqqvgI/bIBWYPMVVAakE58VdTNR\nd5YPgE0YYQKBgQCs14GPkqtpBL9gHYp7yOl9oxxCWeLIw0khDctZfmTprCKj8DVv\n7ksju+TMGWjCEmIQzMqH9Iup12ehcebCaaw2HvIZYyJzQR5+53lENbob6jPn1c3g\n3+VG/Kt8VmBdDWgJtRUyd1TMgj+E6nItw049cr6kSsuCWsT2SIsne5IDPQKBgFTo\nLEyY7tuQcsMvFSOpejczxvCwr5yWcT/deGidNhxn/xl/TPtCmIHck+BooZ/IO0hC\nr7SHtPF/FJjLIOwUiCID/M7PuaT2OPPSg6fkgbB2Szqt3vmWlYFHTRMCyaYXQUFn\nwhBF0IuslV9WrcsivBaGjT6oIeAWIp7dIgARaAFBAoGAaxtXddk1EnQSrl5wYWrC\n6dZ81qb4nZPb8JeWxOYU/6eLTxcoV2btQ7fVYo+HVVtvuxWKgZU9o4PDyiN7uZRx\ng4Ini7VbprcMsxn98ejuPUn9Zwl/4H4rGB94pxTouETVYHeiKjH7dbvOg/VjZ8wh\niLsLJ66zwrSvmyQebcpL7GE=\n-----END PRIVATE KEY-----\n",
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
Worksheet? _userSheet2;
 
static final UserSheetApi _instance = UserSheetApi._internal();  //Declaro el campo estatico privado y utilizo un constructor privado



 static UserSheetApi getinstance(){ //devuelve la instancia
    return _instance;
 }

 UserSheetApi._internal(); //Nadie fuera de la clase puede generar nuevas instancias ya que este es su constructor privado




// Incializo los atributos clase
Future init () async {  
   if (_userSheet != null && _userSheet2 != null){ //Si tengo un usersheet lo devuelve
       return; 
}
      else {  
          try {
          final spreadsheet = await _gsheets.spreadsheet(_spreedsheetId);  //obtengo la spreedsheet
          _userSheet = await _getWorkSheet(spreadsheet , title: 'Usuarios'); //obtengo la hoja usuarios
          _userSheet2 = await _getWorkSheet(spreadsheet , title: 'Carta'); 
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




  
  Worksheet? getSpreedsheet() {
    return _userSheet2;
  }

}