import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
    this.transactions,
  );

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Nenhuma transação cadastrada!',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                SizedBox(
                  height: 200, //se ajustar por este tamanho
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover, //Se ajustar ao tamanho
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'R\$${NumberFormat("###.00", "pt_BR").format(tr.value)}',
                          /*.toString() */
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/y').format(tr.date),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
