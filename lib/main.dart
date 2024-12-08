import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'disney_model.dart';
import 'disney_list.dart';
import 'new_disney_form.dart';

void main() => runApp(const MyApp()); // La función principal que inicia la aplicación Flutter.


class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor de la clase MyApp, no requiere parámetros adicionales.

  @override // Configura la aplicación, define el tema y la página de inicio.
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My fav Princesses Disney', // Título de la aplicación.
      theme: ThemeData(brightness: Brightness.dark),// Establece un tema oscuro para la aplicación.
      home: const MyHomePage(
        title: 'My fav Princesses Disney', // Título que se mostrará en la AppBar.
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title; // Variable para el título de la aplicación.
  const MyHomePage({super.key, required this.title}); // Constructor para recibir el título.

  @override
  // ignore: library_private_types_in_public_api
  // Crea el estado mutable de la página.
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Lista de princesas de Disney inicial.
  List<Disney> initialDisneys = [
    Disney('Rapunzel', "5614"),
    Disney('Belle', "571"),
    Disney('Jasmine', "3389"),
    Disney('Cinderella', "1285")
  ];

  // Método para mostrar el formulario para agregar una nueva princesa.
  Future _showNewDisneyForm() async {
    // Navega al formulario y espera el retorno de una nueva princesa.
    Disney newDisney = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddDisneyFormPage(); // La página del formulario.
    }));
    //print(newDisney);
    // Se agrega la nueva princesa a la lista inicial.
    initialDisneys.add(newDisney);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>(); // Crea una clave global para el Scaffold.
    // Construcción de la UI con Scaffold para la estructura principal
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)), // Título de la AppBar con color blanco.
        centerTitle: true,
        backgroundColor: const Color(0xFFAD1457), // Establece el color de fondo de la AppBar.
      ),
      body: Container(
        color: const Color(0XFFFFEBEE), // Fondo color rosado claro para el cuerpo de la página.
        child: Center(
          child: DisneyList(initialDisneys), // Muestra la lista de princesas.
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewDisneyForm, // Acción al presionar el FAB: mostrar el formulario.
        backgroundColor: const Color(0xFFAD1457), // Cambia el color del FAB
        child: const Icon(
          Icons.add, // Icono de "agregar"
          color: Colors.white, // Cambia el color del icono
        ),
      ),
    );
  }
}