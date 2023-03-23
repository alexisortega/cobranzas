import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String _selectedMethod="PayPal";
  late String _accountNumber="";
  late String _bankName="";
  late double _amount=0.0;

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Procesar la transacción en Firebase
      // Luego mostrar una pantalla de confirmación
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pago completado'),
            content: Text('El pago se ha procesado correctamente'),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
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
        title: Text('Realizar pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Método de pago',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              Container(
                width: 80,
                height: 50,
                child: DropdownButtonFormField<String>(
                  value: _selectedMethod,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedMethod = newValue!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Transferencia bancaria'),
                      value: 'transferencia',
                    ),
                    DropdownMenuItem(
                      child: Text('PayPal'),
                      value: 'PayPal',
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
              SizedBox(height: 16.0),
              if (_selectedMethod == 'transferencia')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Número de cuenta bancaria',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
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
                        _accountNumber = value!;
                      },
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Nombre del banco',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      decoration: InputDecoration(
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
                        _bankName = value!;
                      },
                    ),
                  ],
                ),
              if (_selectedMethod == 'paypal')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Correo electrónico de PayPal',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
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
              SizedBox(height: 16.0),
              Text(
                'Monto',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
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
                  _amount = double.parse(value!);
                },
              ),
              SizedBox(height: 16.0),
              Center(
                child: TextButton(
                  child: Text('Realizar pago'),
                  onPressed: _submitForm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
