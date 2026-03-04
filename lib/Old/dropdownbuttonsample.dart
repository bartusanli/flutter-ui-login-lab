import 'package:flutter/material.dart';

class Dropdownbuttonsample extends StatefulWidget {
  const Dropdownbuttonsample({super.key});

  @override
  _DropdownbuttonsampleState createState() => _DropdownbuttonsampleState();
}

class _DropdownbuttonsampleState extends State<Dropdownbuttonsample> {
  List<String> carbrands = ["Honda", "Citroen", "Renault", "BMW"];
  String? selectedBrand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("Using DropDown"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const Text("BRAND", style: TextStyle(fontSize: 15)),
              const SizedBox(height: 15),
              DropdownButton<String>(
                items: carbrands.map((val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedBrand = val;
                  });
                },
                value: selectedBrand,
              ),
              const SizedBox(height: 15),
              Text("Selected car: ${selectedBrand ?? ''}", style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}