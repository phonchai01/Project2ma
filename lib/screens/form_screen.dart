import 'package:simple_app/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/provider/transaction_provider.dart';
import 'package:uuid/uuid.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final mixController = TextEditingController();
  final suggestController = TextEditingController(); // เพิ่มตัวแปรนี้
  String? selectedSweetness;
  String? selectedTastyLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มข้อมูล'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ชื่อน้ำปั่น',
              ),
              autofocus: true,
              controller: titleController,
              validator: (String? str) {
                if (str!.isEmpty) {
                  return 'กรุณากรอกข้อมูล';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ส่วนผสมสุดแปลกในน้ำปั่น',
              ),
              controller: mixController,
              validator: (String? str) {
                if (str!.isEmpty) {
                  return 'กรุณากรอกข้อมูล';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'ระดับความหวาน',
              ),
              value: selectedSweetness,
              items: const [
                DropdownMenuItem(value: 'ไม่หวาน', child: Text('ไม่หวาน')),
                DropdownMenuItem(value: 'หวานน้อย', child: Text('หวานน้อย')),
                DropdownMenuItem(value: 'หวานปกติ', child: Text('หวานปกติ')),
                DropdownMenuItem(value: 'หวานปานกลาง', child: Text('หวานปานกลาง')),
                DropdownMenuItem(value: 'หวานมาก', child: Text('หวานมาก')),
              ],
              onChanged: (value) {
                selectedSweetness = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'กรุณาเลือกระดับความหวาน';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'จำนวนเงิน',
              ),
              keyboardType: TextInputType.number,
              controller: amountController,
              validator: (String? input) {
                if (input == null || input.isEmpty) {
                  return 'กรุณากรอกข้อมูล';
                }
                final amount = int.tryParse(input);
                if (amount == null || amount <= 0) {
                  return 'กรุณากรอกข้อมูลมากกว่า 0';
                }
                return null;
              },
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'ระดับความอร่อย',
              ),
              value: selectedTastyLevel,
              items: const [
                DropdownMenuItem(value: 'แย่มาก', child: Text('แย่มาก')),
                DropdownMenuItem(value: 'ไม่อร่อย', child: Text('ไม่อร่อย')),
                DropdownMenuItem(value: 'ปานกลาง', child: Text('ปานกลาง')),
                DropdownMenuItem(value: 'อร่อย', child: Text('อร่อย')),
                DropdownMenuItem(value: 'อร่อยมาก', child: Text('อร่อยมาก')),
              ],
              onChanged: (value) {
                selectedTastyLevel = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'กรุณาเลือกระดับความอร่อย';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ข้อเสนอแนะ',
              ),
              controller: suggestController, // เพิ่ม TextFormField สำหรับข้อเสนอแนะ
            ),
            TextButton(
              child: const Text('บันทึก'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var uuid = Uuid();
                  String id = uuid.v4();

                  var statement = Transactions(
                    id: id,
                    title: titleController.text,
                    amount: amountController.text,
                    mix: mixController.text,
                    lvSweet: selectedSweetness ?? 'ไม่ระบุ',
                    lvTasty: selectedTastyLevel ?? 'ไม่ระบุ',
                    suggest: suggestController.text, // ใช้ suggestController
                    date: DateTime.now(),
                  );

                  var provider = Provider.of<TransactionProvider>(context, listen: false);
                  provider.addTransaction(statement);
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
