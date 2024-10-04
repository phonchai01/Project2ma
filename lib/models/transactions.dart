class Transactions {
  final String id; // Add an id field to identify the transaction
  final String title;
  final String amount;
  final String mix;
  final String lvSweet;
  final String lvTasty;
  final String suggest;
  final DateTime date;

  Transactions({
    required this.id, // Make id a required parameter
    required this.title,
    required this.amount,
    required this.mix,
    required this.lvSweet,
    required this.lvTasty,
    required this.suggest,
    required this.date,
  });
}
