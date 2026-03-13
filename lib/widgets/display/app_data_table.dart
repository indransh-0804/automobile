import 'package:flutter/material.dart';

class AppDataTable extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> rows;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns
            .map((col) => DataColumn(label: Text(col)))
            .toList(),
        rows: rows,
        headingRowColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
      ),
    );
  }
}
