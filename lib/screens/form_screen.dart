import 'package:simple_app/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/provider/transaction_provider.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final lvSweetController = TextEditingController();
  final mixController = TextEditingController();
  final lvTastyController = TextEditingController();
  final suggestController = TextEditingController();

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
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ส่วนผสม',
                  ),
                  controller: mixController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ระดับความหวาน',
                  ),
                  controller: lvSweetController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'จำนวนเงิน',
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: (String? input) {
                    try {
                      String amount = (input!);
                      if (amount == int ) {
                        return 'กรุณากรอกข้อมูลมากกว่า 0 คำ';
                      }
                    } catch (e) {
                      return 'กรุณากรอกข้อมูลเป็นข้อความ';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ระดับความอร่อย',
                  ),
                  controller: lvTastyController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ข้อเสนอแนะ',
                  ),
                  controller: suggestController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextButton(
                    child: const Text('บันทึก'),
                    onPressed: () {
                          if (formKey.currentState!.validate())
                            {
                              // create transaction data object
                              var statement = Transactions(
                                  title: titleController.text,
                                  amount: (amountController.text),
                                  mix: (mixController.text),
                                  lvSweet: (lvSweetController.text),
                                  lvTasty: (lvTastyController.text),
                                  suggest: (suggestController.text),
                                  date: DateTime.now()
                                  );
                            
                              // add transaction data object to provider
                              var provider = Provider.of<TransactionProvider>(context, listen: false);
                              
                              provider.addTransaction(statement);

                              Navigator.pop(context);
                            }
                        })
              ],
            )));
  }
}