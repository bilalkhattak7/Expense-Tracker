import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime? _selectedDate;
  String? _selectcategory;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  final Map<String, IconData> categoryIcons = {
    "Food": Icons.fastfood,
    "Travel": Icons.flight_takeoff,
    "Shopping": Icons.shopping_cart,
    "Entertainment": Icons.movie,
    "Utilities": Icons.electrical_services,
    "Rent": Icons.house,
    "Healthcare": Icons.local_hospital,
    "Personal Care": Icons.spa,
    "Education": Icons.school,
    "Gifts & Donations": Icons.card_giftcard,
    "Other": Icons.more_horiz,
  };
  final List<String> categories = [
    "Food",
    "Travel",
    "Shopping",
    "Entertainment",
    "Utilities",
    "Rent",
    "Healthcare",
    "Personal Care",
    "Education",
    "Gifts & Donations",
    "Other",
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // To save data in Firestore
  Future<void> _saveExpense() async {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectcategory == null ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill required fields")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('expenses').add({
        'title': _titleController.text,
        'amount': double.parse(_amountController.text),
        'category': _selectcategory,
        'date': _selectedDate,
        'note': _noteController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data is successfully added.")),
      );
      // Code to clear controllers and state after a successful save
      _titleController.clear();
      _amountController.clear();
      _noteController.clear();
      setState(() {
        _selectcategory = null;
        _selectedDate = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save expense: $e')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                "Add your Expense Here!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "e.g Coffee",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                  hintText: "e.g 100",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectcategory,
                hint: const Text('Select a Category'),
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Row(
                      children: [
                        Icon(categoryIcons[category]),
                        const SizedBox(width: 10),
                        Text(category),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectcategory = newValue;
                  });
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () => _selectDate(context),
                child: Text(
                  _selectedDate == null
                      ? 'Select a date'
                      : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _noteController,
                keyboardType: TextInputType.text,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Note",
                  hintText: "Optional",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _saveExpense();
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}