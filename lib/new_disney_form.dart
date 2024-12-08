import 'dart:convert';
import 'dart:io';

import 'package:disney/disney_model.dart';
import 'package:flutter/material.dart';


class AddDisneyFormPage extends StatefulWidget {
  const AddDisneyFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddDisneyFormPageState createState() => _AddDisneyFormPageState();
}

class _AddDisneyFormPageState extends State<AddDisneyFormPage> {
  final List<String> princessName = [
    "Ariel",
    "Snow White",
    "Aurora",
    "Mulan",
    "Pocahontas",
    "Tiana",
    "Moana",
    "Raya"];
  Map<String, String> disneyPrincesses = {}; // Map to store id and title
  String? selectedPrincess;

  Future<void> RellenarLista() async {
    HttpClient http = HttpClient();
    for (var name in princessName) {
      try {
        var uri = Uri.https('api.disneyapi.dev', '/character', {'name': name});
        var request = await http.getUrl(uri);
        var response = await request.close();
        var responseBody = await response.transform(utf8.decoder).join();
        var data = json.decode(responseBody);
        try {
          disneyPrincesses[name] = data["data"]["_id"].toString();
        } catch (e) {
          disneyPrincesses[name] = data["data"][1]["_id"].toString();
        }
      } catch (exception) {
        print(exception);
      }
    }
    setState(() {}); // Updates UI after fetching the data
  }

  void submitPup(BuildContext context) {
    if (selectedPrincess == null || !disneyPrincesses.containsKey(selectedPrincess)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color(0xFFAD1457),
        content: Text('Please select a valid Disney character'),
      ));
    } else {
      var newDisney = Disney(
        selectedPrincess!,
        disneyPrincesses[selectedPrincess]!,
      );
      Navigator.of(context).pop(newDisney);
    }
  }

  @override
  void initState() {
    super.initState();
    RellenarLista(); // Populate the dropdown list when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Disney Character'),
        backgroundColor: const Color(0xFFAD1457),
      ),
      body: Container(
        color: const Color(0XFFFFEBEE),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: disneyPrincesses.isEmpty ? const Column(
                    children: [
                      CircularProgressIndicator(
                        color: Color(0xFFAD1457), // Color del indicador
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Loading Princesses...",
                        style: TextStyle(
                          color: Color(0XFF880E4F),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                )
                // Show a loading spinner while data loads
                    : DropdownButton<String>(
                  isExpanded: true,
                  value: selectedPrincess,
                  hint: const Text(
                    "Select a Disney Princess",
                    style: TextStyle(color: Color(0XFF880E4F)),),
                  items: disneyPrincesses.keys.map((String name) {
                    return DropdownMenuItem<String>(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedPrincess = value;
                    });
                  },
                  style: const TextStyle(
                    color: Color(0XFF880E4F),
                    fontSize: 16,
                  ),
                  dropdownColor: const Color(0XFFFFEBEE),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () => submitPup(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFAD1457),
                        foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Bordes redondeados
                        ),
                      ),
                      child: const Text(
                          'Submit Princess',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}