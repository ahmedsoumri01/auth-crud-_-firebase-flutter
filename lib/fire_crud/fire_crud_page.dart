import 'package:ahmedfoued/fire_crud/update_car_page.dart';
import 'package:ahmedfoued/service/car_service.dart';
import 'package:flutter/material.dart';
import 'add_car_page.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class FireCrudPage extends StatefulWidget {
  const FireCrudPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FireCrudPageState createState() => _FireCrudPageState();
}

class _FireCrudPageState extends State<FireCrudPage> {
  final CarService _carService = CarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car CRUD Page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _carService.getAllCars(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var cars = snapshot.data!.docs;

          List<CarListItem> carWidgets = [];
          for (var car in cars) {
            var carId = car.id;
            var carName = car['carName'];
            var carColor = car['color'];
            var carPrice = car['price'];
            var carNumOfHorse = car['numOfHorse'];

            var carItem = CarListItem(
              id: carId,
              name: carName,
              color: carColor,
              price: carPrice,
              numOfHorse: carNumOfHorse,
              onEditPressed: () => _navigateToUpdateCarPage(context, carId),
              onDeletePressed: () => _showDeleteConfirmationDialog(context, carId),
            );
            carWidgets.add(carItem);
          }

          return ListView(
            children: carWidgets,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddCarPage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddCarPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddCarPage(),
      ),
    );
  }

  void _navigateToUpdateCarPage(BuildContext context, String carId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateCarPage(carId: carId),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String carId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Car'),
          content: const Text('Are you sure you want to delete this car?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteCar(context, carId);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

void _deleteCar(BuildContext context, String carId) {
  _carService.deleteCar(carId).then((value) {
    // Car deleted successfully
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Car deleted successfully'),
      ),
    );

    // You need to refresh the UI after deletion
    // Fetch cars again and update the UI
    setState(() {});

  }).catchError((error) {
    // Handle errors during car deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error deleting car: $error'),
      ),
    );
  });

  Navigator.of(context).pop(); // Close the delete confirmation dialog
}



}

class CarListItem extends StatelessWidget {
  final String id;
  final String name;
  final String color;
  final double price;
  final int numOfHorse;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const CarListItem({
    super.key,
    required this.id,
    required this.name,
    required this.color,
    required this.price,
    required this.numOfHorse,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$name - $color'),
      subtitle: Text('Price: $price - Horse: $numOfHorse'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEditPressed,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDeletePressed,
          ),
        ],
      ),
      onTap: () {
        // Handle item tap, e.g., navigate to details page
      },
    );
  }
}
