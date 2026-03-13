import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:automobile/models/purchase_model.dart';
import 'package:automobile/models/car_model.dart';
import 'package:automobile/core/utils/formatters.dart';

class PdfService {
  static Future<void> generatePurchaseBill(
      PurchaseModel purchase, CarModel car) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'AutoMobile',
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Center(
                child: pw.Text(
                  'Purchase Bill',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 16),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(1),
                  1: const pw.FlexColumnWidth(2),
                },
                children: [
                  _buildTableRow('Bill ID', purchase.id),
                  _buildTableRow('Date', Formatters.formatDate(purchase.date)),
                  _buildTableRow('Customer', purchase.customerName),
                  _buildTableRow('Car', '${car.make} ${car.model} (${car.year})'),
                  _buildTableRow('VIN', car.vin),
                  _buildTableRow('Color', car.color),
                  _buildTableRow(
                      'Sale Price', Formatters.formatCurrency(purchase.salePrice)),
                  _buildTableRow('Payment Method', purchase.paymentMethod),
                  if (purchase.notes.isNotEmpty)
                    _buildTableRow('Notes', purchase.notes),
                ],
              ),
              pw.SizedBox(height: 24),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'Total: ${Formatters.formatCurrency(purchase.salePrice)}',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.Spacer(),
              pw.Divider(),
              pw.Center(
                child: pw.Text(
                  'Thank you for your purchase!',
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Center(
                child: pw.Text(
                  'AutoMobile - Your Trusted Car Dealer',
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'purchase_bill_${purchase.id}.pdf',
    );
  }

  static pw.TableRow _buildTableRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            label,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(value),
        ),
      ],
    );
  }
}
