import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  String? _selectcategory;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                "Add your Expense Here!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
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
                padding: const EdgeInsets.all(20),
                child: TextFormField(
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

        
        
          ],
        ),
      ),

    );
  }
}
