import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/router/route_names.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/providers/dashboard_provider.dart';
import 'package:automobile/widgets/display/app_section_header.dart';
import 'package:automobile/widgets/display/app_empty_state.dart';

class RecentSalesList extends ConsumerWidget {
  const RecentSalesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSales = ref.watch(recentSalesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: 'Recent Sales',
          trailingLabel: 'View All',
          onTrailingTap: () => context.goNamed(RouteNames.salesSummary),
        ),
        if (recentSales.isEmpty)
          const AppEmptyState(
            icon: Icons.receipt_long,
            title: 'No Recent Sales',
            subtitle: 'Sales will appear here once transactions are recorded.',
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentSales.length,
            itemBuilder: (context, index) {
              final sale = recentSales[index];
              return ListTile(
                title: Text(sale.purchaseId),
                subtitle: Text(Formatters.formatDate(sale.date)),
                trailing: Text(
                  Formatters.formatCurrency(sale.amount),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              );
            },
          ),
      ],
    );
  }
}
