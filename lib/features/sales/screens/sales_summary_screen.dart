import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/providers/sale_provider.dart';
import 'package:automobile/widgets/display/app_stat_card.dart';
import 'package:automobile/widgets/display/app_data_table.dart';
import 'package:automobile/widgets/display/app_loading_indicator.dart';
import 'package:automobile/widgets/display/app_empty_state.dart';

class SalesSummaryScreen extends ConsumerWidget {
  const SalesSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesAsync = ref.watch(salesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sales Summary')),
      body: salesAsync.when(
        data: (sales) {
          if (sales.isEmpty) {
            return const AppEmptyState(
              icon: Icons.trending_up,
              title: 'No Sales',
              subtitle: 'Sales records will appear here.',
            );
          }
          final totalAmount =
              sales.fold<double>(0, (sum, s) => sum + s.amount);

          return SingleChildScrollView(
            padding: EdgeInsets.all(kBaseUnit * 2),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AppStatCard(
                    title: 'Total Sales',
                    value: Formatters.formatCurrency(totalAmount),
                    icon: Icons.trending_up,
                  ),
                ),
                SizedBox(height: kBaseUnit * 2),
                AppDataTable(
                  columns: const [
                    'Date',
                    'Purchase ID',
                    'Amount',
                    'Payment Method',
                    'Employee',
                  ],
                  rows: sales
                      .map((sale) => DataRow(cells: [
                            DataCell(Text(Formatters.formatDate(sale.date))),
                            DataCell(Text(sale.purchaseId)),
                            DataCell(
                                Text(Formatters.formatCurrency(sale.amount))),
                            DataCell(Text(sale.paymentMethod)),
                            DataCell(Text(sale.employeeId)),
                          ]))
                      .toList(),
                ),
              ],
            ),
          );
        },
        loading: () => const AppLoadingIndicator(),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}
