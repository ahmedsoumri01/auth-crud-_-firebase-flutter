import 'package:flutter/material.dart';
import 'package:ahmedfoued/service/car_service.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _numOfHorseController = TextEditingController();
  final CarService _carService = CarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _carNameController,
              decoration: const InputDecoration(labelText: 'Car Name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _colorController,
              decoration: const InputDecoration(labelText: 'Color'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _numOfHorseController,
              decoration: const InputDecoration(labelText: 'Number of Horse'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _addCarToFirestore();
              },
              child: const Text('Add Car'),
            ),
          ],
        ),
      ),
    );
  }

  void _addCarToFirestore() {
    String carName = _carNameController.text;
    String color = _colorController.text;
    double price = double.parse(_priceController.text);
    int numOfHorse = int.parse(_numOfHorseController.text);

    _carService.addCar(carName, color, price, numOfHorse).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Car added successfully'),
        ),
      );
      _carNameController.clear();
      _colorController.clear();
      _priceController.clear();
      _numOfHorseController.clear();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding car: $error'),
        ),
      );
    });
  }
}
