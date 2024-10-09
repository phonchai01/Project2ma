import 'package:flutter/material.dart';
import 'package:simple_app/screens/form_screen.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/provider/transaction_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'น้ำปั่นสุดแปลก'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.transactions.isEmpty) {
            return const Center(
              child: Text('ไม่มีรายการ'),
            );
          } else {
            return SingleChildScrollView(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.transactions.length,
                itemBuilder: (context, index) {
                  var statement = provider.transactions[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          statement.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ส่วนผสม: ${statement.mix}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                          Text('ความหวาน: ${statement.lvSweet}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                          Text('จำนวนเงิน: ${statement.amount} บาท', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                          Text('ความอร่อย: ${statement.lvTasty}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                          Text('ข้อเสนอแนะ: ${statement.suggest}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.black)),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('ยืนยันการลบ'),
                                content: const Text('คุณแน่ใจหรือไม่ว่าต้องการลบรายการนี้?'),
                                actions: [
                                  TextButton(
                                    child: const Text('ยกเลิก'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('ยืนยัน'),
                                    onPressed: () {
                                      provider.deleteTransaction(index);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormScreen();
          }));
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.yellow,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
