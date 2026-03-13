import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/core/constants/app_constants.dart';
import 'package:automobile/providers/loan_provider.dart';
import 'package:automobile/models/loan_model.dart';
import 'package:automobile/core/utils/formatters.dart';
import 'package:automobile/widgets/display/app_badge.dart';
import 'package:automobile/widgets/display/app_loading_indicator.dart';
import 'package:automobile/widgets/display/app_empty_state.dart';
import 'package:automobile/widgets/feedback/app_confirm_dialog.dart';
import 'package:automobile/widgets/feedback/app_snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:automobile/core/router/route_names.dart';

class LoanScreen extends ConsumerWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loansAsync = ref.watch(loansProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Loans')),
      body: loansAsync.when(
        data: (loans) {
          if (loans.isEmpty) {
            return const AppEmptyState(
              icon: Icons.account_balance,
              title: 'No Loans',
              subtitle: 'Loan records will appear here.',
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(kBaseUnit * 2),
            itemCount: loans.length,
            itemBuilder: (context, index) {
              final loan = loans[index];
              return Card(
                margin: EdgeInsets.only(bottom: kBaseUnit),
                child: ListTile(
                  title: Text(loan.customerName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(loan.carName),
                      Text(
                        '${Formatters.formatCurrency(loan.principal)} • ${loan.termMonths} months',
                      ),
                    ],
                  ),
                  trailing: AppBadge(label: loan.status.name),
                  isThreeLine: true,
                  onTap: () async {
                    if (loan.status == LoanStatus.active) {
                      final confirmed = await AppConfirmDialog.show(
                        context,
                        title: 'Mark as Paid',
                        message:
                            'Are you sure you want to mark this loan as paid?',
                      );
                      if (confirmed) {
                        try {
                          await ref
                              .read(loanControllerProvider)
                              .updateLoanStatus(loan.id, LoanStatus.paid);
                          if (context.mounted) {
                            AppSnackbar.showSuccess(
                                context, 'Loan marked as paid');
                          }
                        } catch (e) {
                          if (context.mounted) {
                            AppSnackbar.showError(context, e.toString());
                          }
                        }
                      }
                    }
                  },
                ),
              );
            },
          );
        },
        loading: () => const AppLoadingIndicator(),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(RouteNames.loanForm),
        child: const Icon(Icons.add),
      ),
    );
  }
}
