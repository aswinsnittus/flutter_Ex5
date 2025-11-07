import 'package:flutter/material.dart';
import 'user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _salaryController = TextEditingController();
  final _debtController = TextEditingController();
  final _loanController = TextEditingController();

  void _navigateToResult() {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        salary: double.parse(_salaryController.text),
        debt: double.parse(_debtController.text),
        loan: double.parse(_loanController.text),
      );
      Navigator.pushNamed(context, '/result', arguments: user);
    }
  }

  void _resetFields() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _ageController.clear();
    _salaryController.clear();
    _debtController.clear();
    _loanController.clear();
  }

  Widget _buildNumberField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Enter $label';
          final numValue = double.tryParse(value);
          if (numValue == null || numValue <= 0) return 'Enter a valid number';
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Eligibility - Input Form'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Customer Name', border: OutlineInputBorder()),
                  validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
                ),
                const SizedBox(height: 8),
                _buildNumberField('Age', _ageController),
                _buildNumberField('Monthly Salary (₹)', _salaryController),
                _buildNumberField('Existing EMI/Debts (₹)', _debtController),
                _buildNumberField('Loan Amount Requested (₹)', _loanController),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: _navigateToResult, child: const Text('Check Eligibility')),
                    OutlinedButton(onPressed: _resetFields, child: const Text('Reset')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _salaryController.dispose();
    _debtController.dispose();
    _loanController.dispose();
    super.dispose();
  }
}
