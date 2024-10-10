import 'package:flutter/foundation.dart';
import 'package:simple_app/models/transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void addTransaction(Transactions transaction) async {
    transactions.insert(0, transaction);
    notifyListeners();
  }

  void updateTransaction(Transactions transaction) {
    final index = transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      transactions[index] = transaction; // อัปเดตรายการที่มีอยู่
      notifyListeners();
    }
  }

  void deleteTransaction(int index) {
    transactions.removeAt(index);
    notifyListeners();
  }
}
