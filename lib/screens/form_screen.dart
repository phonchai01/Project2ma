import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/models/transactions.dart';
import 'package:simple_app/provider/transaction_provider.dart';
import 'package:uuid/uuid.dart';

class FormScreen extends StatefulWidget {
  final Transactions? transaction;

  FormScreen({super.key, this.transaction});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final mixController = TextEditingController();
  final suggestController = TextEditingController();
  String? selectedSweetness;
  String? selectedTastyLevel;
  Color appBarColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.transaction?.title ?? '';
    amountController.text = widget.transaction?.amount ?? '';
    mixController.text = widget.transaction?.mix ?? '';
    suggestController.text = widget.transaction?.suggest ?? '';
    selectedSweetness = widget.transaction?.lvSweet;
    selectedTastyLevel = widget.transaction?.lvTasty;

    titleController.addListener(() => _changeAppBarColor());
    amountController.addListener(() => _changeAppBarColor());
    mixController.addListener(() => _changeAppBarColor());
    suggestController.addListener(() => _changeAppBarColor());
  }

  void _changeAppBarColor() {
    setState(() {
      appBarColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0); // สุ่มสี
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    mixController.dispose();
    suggestController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
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
              style: const TextStyle(fontWeight: FontWeight.bold),
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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'ระดับความหวาน',
              ),
              value: selectedSweetness,
              items: const [
                DropdownMenuItem(value: 'ไม่หวาน', child: Text('ไม่หวาน', style: TextStyle(color: Colors.black))),
                DropdownMenuItem(value: 'หวานน้อย', child: Text('หวานน้อย', style: TextStyle(color: Colors.black))),
                DropdownMenuItem(value: 'หวานปกติ', child: Text('หวานปกติ', style: TextStyle(color: Colors.black))),
                DropdownMenuItem(value: 'หวานปานกลาง', child: Text('หวานปานกลาง', style: TextStyle(color: Colors.black))),
                DropdownMenuItem(value: 'หวานมาก', child: Text('หวานมาก', style: TextStyle(color: Colors.black))),
              ],
              onChanged: (value) {
                setState(() {
                  selectedSweetness = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'กรุณาเลือกระดับความหวาน';
                }
                return null;
              },
              style: const TextStyle(fontWeight: FontWeight.bold),
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
                return null;
              },
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'ระดับความอร่อย',
              ),
              value: selectedTastyLevel,
              items: const [
                DropdownMenuItem(value: 'ไม่อร่อย', child: Text('ไม่อร่อย', style: TextStyle(color: Colors.black))),
                DropdownMenuItem(value: 'อร่อยน้อย', child: Text('อร่อยน้อย', style: TextStyle(color: Colors.black))),
                DropdownMenuItem(value: 'อร่อยปกติ', child: Text('อร่อยปกติ', style: TextStyle(color: Colors.black))),
                DropdownMenuItem(value: 'อร่อยปานกลาง', child: Text('อร่อยปานกลาง', style: TextStyle(color: Colors.black))),
                DropdownMenuItem(value: 'อร่อยมาก', child: Text('อร่อยมาก', style: TextStyle(color: Colors.black))),
              ],
              onChanged: (value) {
                setState(() {
                  selectedTastyLevel = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'กรุณาเลือกระดับความอร่อย';
                }
                return null;
              },
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'ข้อเสนอแนะ',
              ),
              controller: suggestController,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black,
              ),
              child: TextButton(
                child: const Text(
                  'บันทึก',
                  style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var uuid = Uuid();
                    String id = widget.transaction?.id ?? uuid.v4();

                    var statement = Transactions(
                      id: id,
                      title: titleController.text,
                      amount: amountController.text,
                      mix: mixController.text,
                      lvSweet: selectedSweetness ?? 'ไม่ระบุ',
                      lvTasty: selectedTastyLevel ?? 'ไม่ระบุ',
                      suggest: suggestController.text,
                      date: DateTime.now(),
                    );

                    var provider = Provider.of<TransactionProvider>(context, listen: false);
                    if (widget.transaction == null) {
                      provider.addTransaction(statement);
                    } else {
                      provider.updateTransaction(statement);
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
