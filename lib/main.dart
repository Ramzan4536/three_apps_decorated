
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For Age Calculator date formatting

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedApp = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi App Calculations'),
        centerTitle: true, // Center the title
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGradientButton('BMI Calculator', () {
                  setState(() {
                    _selectedApp = 0;
                  });
                }),
                _buildGradientButton('Tip Calculator', () {
                  setState(() {
                    _selectedApp = 1;
                  });
                }),
                _buildGradientButton('Age Calculator', () {
                  setState(() {
                    _selectedApp = 2;
                  });
                }),
                _buildGradientButton('Currency Converter', () {
                  setState(() {
                    _selectedApp = 3;
                  });
                }),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: _selectedApp == 0
                  ? BmiCalculator()
                  : _selectedApp == 1
                  ? TipCalculator()
                  : _selectedApp == 2
                  ? AgeCalculator()
                  : CurrencyConverter(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

// BMI Calculator with gradient and styling
class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  double _bmiResult = 0;
  String _bmiCategory = '';

  void _calculateBMI(double height, double weight) {
    setState(() {
      _bmiResult = weight / (height * height);
      _bmiCategory = _getBmiCategory(_bmiResult);
    });
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  void _showBmiInputDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final heightController = TextEditingController();
        final weightController = TextEditingController();
        return AlertDialog(
          title: Text('Enter Height and Weight'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                double height = double.parse(heightController.text) / 100;
                double weight = double.parse(weightController.text);
                _calculateBMI(height, weight);
              },
              child: Text('Calculate'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _showBmiInputDialog,
            child: Text('Enter Height and Weight'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 16),
          if (_bmiResult > 0)
            Column(
              children: [
                Text(
                  'Your BMI is ${_bmiResult.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, color: Colors.teal),
                ),
                SizedBox(height: 8),
                Text(
                  'Category: $_bmiCategory',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _getBmiCategoryColor(),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Color _getBmiCategoryColor() {
    switch (_bmiCategory) {
      case 'Underweight':
        return Colors.orangeAccent;
      case 'Normal weight':
        return Colors.green;
      case 'Overweight':
        return Colors.yellowAccent;
      case 'Obese':
        return Colors.redAccent;
      default:
        return Colors.black;
    }
  }
}

// Tip Calculator with gradient and styling
class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  double _totalAmount = 0;

  void _calculateTip(double bill, double tipPercentage) {
    setState(() {
      _totalAmount = bill + (bill * tipPercentage / 100);
    });
  }

  void _showTipInputDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final billController = TextEditingController();
        final tipPercentageController = TextEditingController();
        return AlertDialog(
          title: Text('Enter Bill and Tip Percentage'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: billController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Bill Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: tipPercentageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tip Percentage',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                double bill = double.parse(billController.text);
                double tipPercentage = double.parse(tipPercentageController.text);
                _calculateTip(bill, tipPercentage);
              },
              child: Text('Calculate'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _showTipInputDialog,
            child: Text('Enter Bill and Tip Percentage'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 16),
          if (_totalAmount > 0)
            Text(
              'Total Amount: ${_totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, color: Colors.teal),
            ),
        ],
      ),
    );
  }
}

// Age Calculator with gradient and styling
class AgeCalculator extends StatefulWidget {
  @override
  _AgeCalculatorState createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  final TextEditingController _dateController = TextEditingController();
  String _ageResult = '';

  void _calculateAge() {
    try {
      DateTime birthDate = DateFormat('dd/MM/yyyy').parse(_dateController.text);
      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      setState(() {
        _ageResult = 'You are $age years old';
      });
    } catch (e) {
      setState(() {
        _ageResult = 'Invalid date format';
      });
    }
  }

  void _showDateInputDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Your Birthdate'),
          content: TextField(
            controller: _dateController,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              labelText: 'Date of Birth (dd/MM/yyyy)',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _calculateAge();
              },
              child: Text('Calculate'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _showDateInputDialog,
            child: Text('Enter Birthdate'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            _ageResult,
            style: TextStyle(fontSize: 24, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}

// Currency Converter with gradient and styling
class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _amountController = TextEditingController();
  String _convertedAmount = '';
  String _selectedCurrency = 'USD';

  final Map<String, double> _conversionRates = {
    'USD': 0.06, // Example rate
    'EUR': 0.055,
    'GBP': 0.045,
  };

  void _convertCurrency() {
    try {
      double amount = double.parse(_amountController.text);
      double rate = _conversionRates[_selectedCurrency] ?? 1.0;
      setState(() {
        _convertedAmount = 'Converted Amount: ${(amount * rate).toStringAsFixed(2)} $_selectedCurrency';
      });
    } catch (e) {
      setState(() {
        _convertedAmount = 'Invalid amount';
      });
    }
  }

  void _showCurrencyInputDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Amount and Select Currency'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCurrency = newValue!;
                  });
                },
                items: _conversionRates.keys.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                isExpanded: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _convertCurrency();
              },
              child: Text('Convert'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _showCurrencyInputDialog,
            child: Text('Enter Amount and Currency'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            _convertedAmount,
            style: TextStyle(fontSize: 24, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}









