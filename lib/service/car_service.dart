// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

class CarService {
  final CollectionReference _carCollection = FirebaseFirestore.instance.collection('cars');

  Future<void> addCar(String carName, String color, double price, int numOfHorse) async {
    await _carCollection.add({
      'carName': carName,
      'color': color,
      'price': price,
      'numOfHorse': numOfHorse,
    });
  }

  Future<void> deleteCar(String carId) async {
    await _carCollection.doc(carId).delete();
  }

  Future<void> updateCar(String carId, String newCarName, String newColor, double newPrice, int newNumOfHorse) async {
    await _carCollection.doc(carId).update({
      'carName': newCarName,
      'color': newColor,
      'price': newPrice,
      'numOfHorse': newNumOfHorse,
    });
  }

  Future<DocumentSnapshot<Object?>> getCarById(String carId) async {
    return await _carCollection.doc(carId).get();
  }

  Stream<QuerySnapshot<Object?>> getAllCars() {
    return _carCollection.snapshots();
  }
}
