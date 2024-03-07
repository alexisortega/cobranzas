// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  late String _selectedMethod = "PayPal";
  late String accountNumber = "";
  late String bankName = "";
  late double amount = 0.0;

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Procesar la transacción en Firebase
      // Luego mostrar una pantalla de confirmación
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pago completado'),
            content: const Text('El pago se ha procesado correctamente'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realizar pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Método de pago',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 8.0),
              Container(
                color: Colors.transparent,
                width: 800,
                height: 50,
                child: DropdownButtonFormField<String>(
                  value: _selectedMethod,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedMethod = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'transferencia',
                      child: Text('Transferencia bancaria'),
                    ),
                    DropdownMenuItem(
                      value: 'PayPal',
                      child: Text('PayPal'),
                    ),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'Seleccione un método de pago';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              if (_selectedMethod == 'transferencia')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Número de cuenta bancaria',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Ingrese el número de cuenta bancaria',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese el número de cuenta bancaria';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        accountNumber = value!;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Nombre del banco',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Ingrese el nombre del banco',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese el nombre del banco';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        bankName = value!;
                      },
                    ),
                  ],
                ),
              if (_selectedMethod == 'paypal')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Correo electrónico de PayPal',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Ingrese su correo electrónico de PayPal',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese su correo electrónico de PayPal';
                        }
                        if (!value.contains('@')) {
                          return 'Ingrese una dirección de correo electrónico válida';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // Guardar el correo electrónico de PayPal en Firebase
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),
              const Text(
                'Monto',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ingrese el monto a pagar',
                  border: OutlineInputBorder(),
                  prefixText: '\$',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el monto a pagar';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Ingrese un número válido';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Ingrese un monto mayor a cero';
                  }
                  return null;
                },
                onSaved: (value) {
                  amount = double.parse(value!);
                },
              ),
              const SizedBox(height: 16.0),
              Center(
                child: TextButton(
                  onPressed: _submitForm,
                  child: const Text('Realizar pago'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
