import 'package:flutter/material.dart';
import 'dart:math';  // Import this for the sqrt function

void main() {
  runApp(MultiCalculatorApp());
}

class MultiCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiCalculatorScreen(),
    );
  }
}

class MultiCalculatorScreen extends StatefulWidget {
  @override
  _MultiCalculatorScreenState createState() => _MultiCalculatorScreenState();
}

class _MultiCalculatorScreenState extends State<MultiCalculatorScreen> {
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _tipController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _quadraticAController = TextEditingController();
  final TextEditingController _quadraticBController = TextEditingController();
  final TextEditingController _quadraticCController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _fuelConsumedController = TextEditingController();
  final TextEditingController _distanceFuelController = TextEditingController();
  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _discountPercentageController = TextEditingController();
  final TextEditingController _distanceSDTController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();

  final List<String> _todoList = [];
  final List<bool> _completedList = [];

  void _showBMIDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('BMI Calculator', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _bmiController,
                decoration: InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _bmiController,
                decoration: InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double weight = double.parse(_bmiController.text);
                double height = double.parse(_bmiController.text) / 100;
                double bmi = weight / (height * height);
                _showResultDialog('BMI: ${bmi.toStringAsFixed(2)}');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  void _showAgeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Age Calculator', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          content: TextField(
            controller: _ageController,
            decoration: InputDecoration(labelText: 'Enter your birth year', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                int birthYear = int.parse(_ageController.text);
                int currentYear = DateTime.now().year;
                int age = currentYear - birthYear;
                _showResultDialog('Your Age: $age years');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  void _showTipDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Tip Calculator', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tipController,
                decoration: InputDecoration(labelText: 'Total Amount', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _tipController,
                decoration: InputDecoration(labelText: 'Tip Percentage', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double totalAmount = double.parse(_tipController.text);
                double tipPercentage = double.parse(_tipController.text);
                double tipAmount = totalAmount * (tipPercentage / 100);
                double finalAmount = totalAmount + tipAmount;
                _showResultDialog('Tip Amount: \$${tipAmount.toStringAsFixed(2)}\nFinal Amount: \$${finalAmount.toStringAsFixed(2)}');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Currency Converter', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
          content: TextField(
            controller: _currencyController,
            decoration: InputDecoration(labelText: 'Amount in USD', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double amount = double.parse(_currencyController.text);
                double convertedAmount = amount * 74; // Example conversion rate
                _showResultDialog('Amount in PKR: ${convertedAmount.toStringAsFixed(2)}');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: Text('Convert'),
            ),
          ],
        );
      },
    );
  }

  void _showQuadraticDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Quadratic Solver', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _quadraticAController,
                decoration: InputDecoration(labelText: 'Coefficient a', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _quadraticBController,
                decoration: InputDecoration(labelText: 'Coefficient b', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _quadraticCController,
                decoration: InputDecoration(labelText: 'Coefficient c', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double a = double.parse(_quadraticAController.text);
                double b = double.parse(_quadraticBController.text);
                double c = double.parse(_quadraticCController.text);
                double discriminant = (b * b) - (4 * a * c);

                if (discriminant > 0) {
                  double root1 = (-b + sqrt(discriminant)) / (2 * a); // Corrected sqrt function
                  double root2 = (-b - sqrt(discriminant)) / (2 * a); // Corrected sqrt function
                  _showResultDialog('Roots: $root1 and $root2');
                } else if (discriminant == 0) {
                  double root = -b / (2 * a);
                  _showResultDialog('Root: $root');
                } else {
                  _showResultDialog('No Real Roots');
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: Text('Solve'),
            ),
          ],
        );
      },
    );
  }

  void _showTemperatureDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Temperature Converter', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          content: TextField(
            controller: _temperatureController,
            decoration: InputDecoration(labelText: 'Temperature in Celsius', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double celsius = double.parse(_temperatureController.text);
                double fahrenheit = (celsius * 9/5) + 32;
                _showResultDialog('Temperature in Fahrenheit: ${fahrenheit.toStringAsFixed(2)}');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Convert'),
            ),
          ],
        );
      },
    );
  }

  void _showFuelDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Fuel Consumption Calculator', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _fuelConsumedController,
                decoration: InputDecoration(labelText: 'Fuel Consumed (liters)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _distanceFuelController,
                decoration: InputDecoration(labelText: 'Distance Traveled (km)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double fuelConsumed = double.parse(_fuelConsumedController.text);
                double distanceTraveled = double.parse(_distanceFuelController.text);
                double consumption = fuelConsumed / distanceTraveled * 100;
                _showResultDialog('Fuel Consumption: ${consumption.toStringAsFixed(2)} L/100km');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  void _showDiscountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Discount Calculator', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _originalPriceController,
                decoration: InputDecoration(labelText: 'Original Price', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _discountPercentageController,
                decoration: InputDecoration(labelText: 'Discount Percentage', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double originalPrice = double.parse(_originalPriceController.text);
                double discountPercentage = double.parse(_discountPercentageController.text);
                double discountAmount = originalPrice * (discountPercentage / 100);
                double finalPrice = originalPrice - discountAmount;
                _showResultDialog('Discount Amount: \$${discountAmount.toStringAsFixed(2)}\nFinal Price: \$${finalPrice.toStringAsFixed(2)}');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  void _showSpeedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Speed Calculator', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _distanceSDTController,
                decoration: InputDecoration(labelText: 'Distance (km)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time (hours)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double distance = double.parse(_distanceSDTController.text);
                double time = double.parse(_timeController.text);
                double speed = distance / time;
                _showResultDialog('Speed: ${speed.toStringAsFixed(2)} km/h');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  void _showTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('To-Do List', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _todoController,
                decoration: InputDecoration(labelText: 'Enter task', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _todoList.add(_todoController.text);
                    _completedList.add(false);
                    _todoController.clear();
                  });
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: Text('Add Task'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Result', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          content: Text(result),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Calculator'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(8),
        children: [
          _buildCalculatorButton('BMI Calculator', Colors.blue, _showBMIDialog),
          _buildCalculatorButton('Age Calculator', Colors.green, _showAgeDialog),
          _buildCalculatorButton('Tip Calculator', Colors.orange, _showTipDialog),
          _buildCalculatorButton('Currency Converter', Colors.blueAccent, _showCurrencyDialog),
          _buildCalculatorButton('Quadratic Solver', Colors.purple, _showQuadraticDialog),
          _buildCalculatorButton('Temperature Converter', Colors.green, _showTemperatureDialog),
          _buildCalculatorButton('Fuel Consumption', Colors.orange, _showFuelDialog),
          _buildCalculatorButton('Discount Calculator', Colors.red, _showDiscountDialog),
          _buildCalculatorButton('Speed Calculator', Colors.deepOrange, _showSpeedDialog),
          _buildCalculatorButton('To-Do List', Colors.teal, _showTodoDialog),
        ],
      ),
    );
  }

  Widget _buildCalculatorButton(String title, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
