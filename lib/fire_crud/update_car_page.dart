import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ahmedfoued/service/car_service.dart';

class UpdateCarPage extends StatefulWidget {
  final String carId;

  const UpdateCarPage({super.key, required this.carId});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateCarPageState createState() => _UpdateCarPageState();
}

class _UpdateCarPageState extends State<UpdateCarPage> {
  final TextEditingController _carNameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _numOfHorseController = TextEditingController();

  late Future<DocumentSnapshot<Object?>> _carData;
  final CarService _carService = CarService();

  @override
  void initState() {
    super.initState();
    _carData = _carService.getCarById(widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Car'),
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: _carData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.data() == null) {
            return const Center(
              child: Text('Car not found.'),
            );
          } else {
            var carData = snapshot.data!.data() as Map<String, dynamic>;
            _carNameController.text = carData['carName'] ?? '';
            _colorController.text = carData['color'] ?? '';
            _priceController.text = (carData['price'] ?? 0.0).toString();
            _numOfHorseController.text = (carData['numOfHorse'] ?? 0).toString();

            return _buildUpdateForm();
          }
        },
      ),
    );
  }

  Widget _buildUpdateForm() {
    return Padding(
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
              _updateCar();
            },
            child: const Text('Update Car'),
          ),
        ],
      ),
    );
  }

  void _updateCar() {
    String newCarName = _carNameController.text;
    String newColor = _colorController.text;
    double newPrice = double.parse(_priceController.text);
    int newNumOfHorse = int.parse(_numOfHorseController.text);

    _carService.updateCar(widget.carId, newCarName, newColor, newPrice, newNumOfHorse).then((value) {
      // Car updated successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Car updated successfully'),
        ),
      );

      // Clear the text fields after updating the car
      _carNameController.clear();
      _colorController.clear();
      _priceController.clear();
      _numOfHorseController.clear();

      // Navigate back to the previous screen
      Navigator.pop(context);
    }).catchError((error) {
      // Handle errors during car update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating car: $error'),
        ),
      );
    });
  }
}
