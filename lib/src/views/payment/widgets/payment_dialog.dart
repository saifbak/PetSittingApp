import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class PaymentDialog extends StatelessWidget {
  const PaymentDialog({
    required this.request,
    required this.completer,
  });
  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return Dialog();
  }
}
