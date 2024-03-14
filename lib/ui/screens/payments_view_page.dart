import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PaymentsViewPage extends StatefulWidget {
  const PaymentsViewPage({super.key});

  @override
  State<PaymentsViewPage> createState() => _PaymentsViewPageState();
}

class _PaymentsViewPageState extends State<PaymentsViewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CustomText(text: "pagina pagos", font: TextStyle()),
      ),
    );
  }
}
