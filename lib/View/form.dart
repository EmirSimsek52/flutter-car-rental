import 'package:flutter/material.dart';

class RentalForm extends StatefulWidget {
  @override
  _RentalFormState createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm> {
  TextEditingController carNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pickupDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController deliveryAddressController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    validateForm();
  }

  void validateForm() {
    bool isValid = carNameController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        pickupDateController.text.isNotEmpty &&
        returnDateController.text.isNotEmpty &&
        deliveryAddressController.text.isNotEmpty;

    setState(() {
      isButtonEnabled = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Car Name'),
            TextFormField(
              controller: carNameController,
              onChanged: (_) => validateForm(),
              decoration: InputDecoration(
                hintText: 'Enter car name',
              ),
            ),
            SizedBox(height: 20),
            Text('Name'),
            TextFormField(
              controller: nameController,
              onChanged: (_) => validateForm(),
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(height: 20),
            Text('Phone Number'),
            TextFormField(
              controller: phoneController,
              onChanged: (_) => validateForm(),
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Text('Pickup Date'),
            TextFormField(
              controller: pickupDateController,
              onChanged: (_) => validateForm(),
              decoration: InputDecoration(
                hintText: 'Enter pickup date',
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            Text('Return Date'),
            TextFormField(
              controller: returnDateController,
              onChanged: (_) => validateForm(),
              decoration: InputDecoration(
                hintText: 'Enter return date',
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            Text('Delivery Address'),
            TextFormField(
              controller: deliveryAddressController,
              onChanged: (_) => validateForm(),
              decoration: InputDecoration(
                hintText: 'Enter delivery address',
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
              onPressed: isButtonEnabled
                  ? () {
                      String carName = carNameController.text;
                      String name = nameController.text;
                      String phone = phoneController.text;
                      String pickupDate = pickupDateController.text;
                      String returnDate = returnDateController.text;
                      String deliveryAddress = deliveryAddressController.text;

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Your Reservation Details'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Car Name: $carName'),
                                Text('Name: $name'),
                                Text('Phone Number: $phone'),
                                Text('Pickup Date: $pickupDate'),
                                Text('Return Date: $returnDate'),
                                Text('Delivery Address: $deliveryAddress'),
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
                  : null,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
