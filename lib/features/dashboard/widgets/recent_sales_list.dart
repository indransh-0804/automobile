import 'package:flutter/material.dart';
import 'package:automobile/core/utils/extensions.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/providers/dashboard_provider.dart';
import 'package:automobile/widgets/display/app_section_header.dart';
import 'package:automobile/widgets/display/app_empty_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentSalesList extends ConsumerWidget {
  const RecentSalesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSales = ref.watch(dashboardProvider).recentSales;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(title: 'Recent Sales'),
          if (recentSales.isEmpty)
            const AppEmptyState(
              icon: Icons.receipt_long,
              title: 'No Recent Sales',
              subtitle: 'Sales will appear here once recorded.',
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentSales.length,
              itemBuilder: (context, index) {
                final sale = recentSales[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(sale.carName),
                  subtitle: Text(sale.date.formattedDate),
                  trailing: Text(
                    Formatters.currency(sale.amount),
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
