import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.00;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day':
            DateFormat.E().format(weekDay)[0], //Pegando a primeira letra do dia
        'value': totalSum,
      };
    }).reversed.toList();
    //reversed devolve um iterable ao inverso
    //toList() pra devolver uma lista
  }

  double get _weekTotalValue {
    //fold() funciona como o reduce
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  const Chart({super.key, required this.recentTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((transaction) {
            double value = (transaction['value'] as double);
            return Flexible(
              //Flexfit.loose (padrao)
              fit: FlexFit.tight,
              child: ChartBar(
                label: transaction['day'].toString(),
                value: value,
                percentage: value / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
