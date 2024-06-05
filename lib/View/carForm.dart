import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';

class CarForm extends StatefulWidget {
  @override
  _CarFormState createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  TextEditingController carNameController = TextEditingController();
  TextEditingController dailyKmController = TextEditingController();
  TextEditingController dailyPriceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    carNameController.addListener(validateForm);
    dailyKmController.addListener(validateForm);
    dailyPriceController.addListener(validateForm);
    imageUrlController.addListener(validateForm);
  }

  void validateForm() {
    bool isValid = carNameController.text.isNotEmpty &&
        dailyKmController.text.isNotEmpty &&
        dailyPriceController.text.isNotEmpty &&
        imageUrlController.text.isNotEmpty;

    setState(() {
      isButtonEnabled = isValid;
    });
  }

  @override
  void dispose() {
    carNameController.dispose();
    dailyKmController.dispose();
    dailyPriceController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    String carName = carNameController.text;
    String dailyKm = dailyKmController.text;
    String dailyPrice = dailyPriceController.text;
    String imageUrl = imageUrlController.text;

    Map<String, dynamic> car = {
      'name': carName,
      'daily_km': dailyKm,
      'daily_price': dailyPrice,
      'image_url': imageUrl,
    };

    await DatabaseHelper().insertCar(car);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Car Added'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Car Name: $carName'),
              Text('Daily Kilometers: $dailyKm'),
              Text('Daily Price: $dailyPrice'),
              Text('Image URL: $imageUrl'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Car Name'),
          TextFormField(
            controller: carNameController,
            decoration: InputDecoration(
              hintText: 'Enter the car name',
            ),
          ),
          SizedBox(height: 20),
          Text('Daily Kilometers'),
          TextFormField(
            controller: dailyKmController,
            decoration: InputDecoration(
              hintText: 'Enter daily kilometers',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          Text('Daily Price USD'),
          TextFormField(
            controller: dailyPriceController,
            decoration: InputDecoration(
              hintText: 'Enter daily price USD',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          Text('Image URL'),
          TextFormField(
            controller: imageUrlController,
            decoration: InputDecoration(
              hintText: 'Enter image URL',
            ),
          ),
          SizedBox(height: 20),
          if (!isButtonEnabled)
            Text(
              'Please fill out all fields',
              style: TextStyle(color: Colors.red),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isButtonEnabled ? _submitForm : null,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
