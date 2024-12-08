// Se ignoran los warnings relacionados con las comparaciones innecesarias de nulos en este archivo.
// ignore_for_file: unnecessary_null_comparison

// Importaciones necesarias para trabajar con HTTP, codificación JSON y el manejo de archivos.
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:async';

// Propiedades de la clase Disney.
class Disney {
  final String name;
  final String id;
  String? imageUrl;
  String? fanPage;
  String? apiname;
  String? levelDisney;

  int rating = 10;

  // Constructor de la clase Disney, requiere un nombre y un ID.
  Disney(this.name, this.id);

  // Método asincrónico para obtener la URL de la imagen del personaje desde una API externa.
  Future getImageUrl() async {
    // Si ya existe una URL de la imagen, simplemente retorna sin hacer nada.
    if (imageUrl != null) {
      return;
    }

    // Crea una instancia de HttpClient para realizar una solicitud HTTP.
    HttpClient http = HttpClient();
    try {
      // Convierte el nombre del personaje a minúsculas para formar el nombre que se utilizará en la API.
      apiname = name.toLowerCase();

      // Construye la URL de la API de Disney para obtener la información del personaje.
      var uri = Uri.https('api.disneyapi.dev', '/character/$id');
      var request = await http.getUrl(uri);// Realiza la solicitud GET a la API con la URL construida.
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();// Lee el cuerpo de la respuesta y lo decodifica en formato UTF-8.
      var data = json.decode(responseBody);// Decodifica el cuerpo de la respuesta JSON

      // Extrae la URL de la imagen desde el JSON de la respuesta y la asigna a la propiedad imageUrl.
      imageUrl = data["data"]["imageUrl"];
      fanPage = data["data"]["sourceUrl"];

      //print(levelDisney);
    } catch (exception) {
      //print(exception);
    }
  }
}
