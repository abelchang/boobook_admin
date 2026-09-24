import 'package:boobook_admin/app/features/orders/model/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersWidget extends StatelessWidget {
  const OrdersWidget({super.key, required this.orders});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    Map<int, int> currentYearSum = {};
    Map<int, int> pastYearsSum = {};

    for (var order in orders) {
      if (order.checkin.year == DateTime.now().year) {
        int month = order.checkin.month;
        currentYearSum.update(month, (value) => (value) + order.price,
            ifAbsent: () => order.price);
      } else {
        int year = order.checkin.year;
        pastYearsSum.update(year, (value) => (value) + order.price,
            ifAbsent: () => order.price);
      }
    }

    var sortedCurrentYearEntries = currentYearSum.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    sortedCurrentYearEntries.sort((a, b) => b.key.compareTo(a.key));
    var sortedPastYearsEntries = pastYearsSum.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    return ListView.builder(
      itemCount:
          sortedCurrentYearEntries.length + sortedPastYearsEntries.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '今年',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          );
        } else if (index <= sortedCurrentYearEntries.length) {
          var entry = sortedCurrentYearEntries[index - 1];
          String title = '${DateTime.now().year}-${entry.key}';
          String formattedPrice =
              NumberFormat.currency(symbol: 'NT\$', decimalDigits: 0)
                  .format(entry.value);
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              ),
              subtitle: Text(
                formattedPrice,
                style: TextStyle(fontSize: 16, color: Colors.pink.shade300),
              ),
            ),
          );
        } else if (index == sortedCurrentYearEntries.length + 1) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '歷年',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          );
        } else {
          var entry = sortedPastYearsEntries[
              index - sortedCurrentYearEntries.length - 2];
          String title = entry.key.toString();
          String formattedPrice =
              NumberFormat.currency(symbol: 'NT\$', decimalDigits: 0)
                  .format(entry.value);
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              ),
              subtitle: Text(
                formattedPrice,
                style: TextStyle(fontSize: 16, color: Colors.pink.shade300),
              ),
            ),
          );
        }
      },
    );
  }
}
