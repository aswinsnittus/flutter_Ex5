import 'package:flutter/material.dart';
import 'user_model.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    double dti = (user.debt / user.salary) * 100;
    bool ageOk = user.age >= 21 && user.age <= 60;
    bool loanLimitOk = user.loan <= (user.salary * 10);
    bool dtiOk = dti <= 60;

    String message;
    Color msgColor;

    if (ageOk && loanLimitOk && dtiOk) {
      message =
          "✅ Eligible! Approved Loan: ₹${user.loan.toStringAsFixed(0)}\nEMI within acceptable limit.";
      msgColor = Colors.green;
    } else {
      message = "❌ Not Eligible due to:\n";
      if (!ageOk) message += "• Age must be between 21 and 60\n";
      if (!loanLimitOk)
        message += "• Loan exceeds 10× Monthly Salary\n";
      if (!dtiOk)
        message += "• Debt-to-Income ratio exceeds 60%\n";
      msgColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Eligibility Result'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${user.name}", style: const TextStyle(fontSize: 18)),
                Text("Age: ${user.age}", style: const TextStyle(fontSize: 18)),
                Text("Monthly Salary: ₹${user.salary.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18)),
                Text("Existing Debts: ₹${user.debt.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18)),
                Text("Loan Requested: ₹${user.loan.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: msgColor),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
