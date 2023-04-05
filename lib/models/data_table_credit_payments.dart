import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/constants.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: depend_on_referenced_packages

class creditPayments extends StatefulWidget {
  //datos del prestamo
  final int numero_pagos;
  final String plazos;
  final double monto_solicitado;
  final DateTime fecha_prestamo;
  final double interes_asignado;
  //datos de credito
  final String codigo_credito;
  final String propietario_credito;
  final List<String>? dias_semana;
  //datos del cliente
  final String codigo_cliente;

  const creditPayments({
    super.key,
    //datos de credito
    required this.codigo_credito,
    required this.propietario_credito,
    required this.dias_semana,

    //datos del prestamo
    required this.numero_pagos,
    required this.plazos,
    required this.monto_solicitado,
    required this.fecha_prestamo,
    required this.interes_asignado,
    required this.codigo_cliente,
  });

  @override
  State<creditPayments> createState() => _creditPaymentsState();
}

class _creditPaymentsState extends State<creditPayments> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Stream<DocumentSnapshot> clienteStream = FirebaseFirestore.instance
        .collection('clientes')
        .doc(widget.codigo_cliente)
        .snapshots();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Expanded(
              flex: 6,
              child: Container(
                  color: Colors.transparent,
                  child: Row(children: [
                    Container(
                      height: size.height / 2,
                      width: size.width / 1.13,
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: Offset(10, 10),
                          ),
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nombre completo:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "alexis ortega badillo",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Código de cliente:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "265105",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Teléfono:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "7751506515",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ]))),
          Expanded(
              flex: 6,
              child: paymentNumberList(
                widget.numero_pagos,
                widget.fecha_prestamo,
                widget.plazos,
                widget.monto_solicitado,
                widget.interes_asignado,
              )),
          SizedBox(
            height: 10,
          ),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          //Generar PDF
                        },
                        child: Text("Generar PDF")),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton.icon(
                      onPressed: () {
//funcion guardar en firebase
                      },
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text("Guardar"),
                    ),
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  paymentNumberList(
    int numeroPagos,
    DateTime fechaPrestamo,
    String plazos,
    double montoPrestamo,
    double tasaInteres,
  ) {
    List<DataRow> dataRows = [];
    double InteresperiodoPlazo = 0.0;
    double cuotaPlazo = 0.0;
    double capitalInsoluto = montoPrestamo;
    double saldoInsoluto;
    double abonoTotal;
    double interesTotal;
    double amortizacion;
    double sumaTotal = 0.0;
    double sumaInteres = 0.0;
    double CapitalTotal = 0.0;
    double sumaTotal2D = 0.0;
    double sumaInteres2D = 0.0;
    double CapitalTotal2D = 0.0;

    tasaInteres = tasaInteres / 100;
    print("Tasa de interes anual: $tasaInteres");

    if (plazos.toString().isCaseInsensitiveContains("diario")) {
      InteresperiodoPlazo = tasaInteres / 365;
      cuotaPlazo = montoPrestamo *
          InteresperiodoPlazo /
          (1 - pow(1 + InteresperiodoPlazo, -numeroPagos));

      print("interes periodo diario " "$InteresperiodoPlazo");
      print("Cuota diario $cuotaPlazo ");
    }
    if (plazos.toString().isCaseInsensitiveContains("semanal")) {
      InteresperiodoPlazo = tasaInteres / 52;
      cuotaPlazo = montoPrestamo *
          InteresperiodoPlazo /
          (1 - pow(1 + InteresperiodoPlazo, -numeroPagos));

      print("interes periodo semanal " "$InteresperiodoPlazo");
      print("Cuota semanal $cuotaPlazo ");
    } else if (plazos.toString().isCaseInsensitiveContains("catorcenal")) {
      InteresperiodoPlazo = tasaInteres / 26;
      cuotaPlazo = montoPrestamo *
          InteresperiodoPlazo /
          (1 - pow(1 + InteresperiodoPlazo, -numeroPagos));

      print("interes periodo catorcenal " "$InteresperiodoPlazo");
      print("Cuota catorcenal $cuotaPlazo ");
    } else if (plazos.toString().isCaseInsensitiveContains("quincenal")) {
      InteresperiodoPlazo = tasaInteres / 12;
      cuotaPlazo = montoPrestamo *
          InteresperiodoPlazo /
          (1 - pow(1 + InteresperiodoPlazo, -numeroPagos));

      print("interes periodo quincenal " "$InteresperiodoPlazo");
      print("Cuota quincenal $cuotaPlazo ");
    } else if (plazos.toString().isCaseInsensitiveContains("mensual")) {
      InteresperiodoPlazo = tasaInteres / 12;
      cuotaPlazo = montoPrestamo *
          InteresperiodoPlazo /
          (1 - pow(1 + InteresperiodoPlazo, -numeroPagos));

      print("interes periodo mensual " "$InteresperiodoPlazo");
      print("Cuota mensual $cuotaPlazo ");
    }
    saldoInsoluto = montoPrestamo;
    amortizacion = 0.0;
    for (var i = 0; i < numeroPagos; i++) {
      int index = i + 1;

      abonoTotal = cuotaPlazo;
      capitalInsoluto = saldoInsoluto;
      if (i == 0) {
        saldoInsoluto = montoPrestamo;
        capitalInsoluto = montoPrestamo;
      }

      interesTotal = capitalInsoluto * InteresperiodoPlazo;
      amortizacion = abonoTotal - interesTotal;
      saldoInsoluto = saldoInsoluto - amortizacion;

      var formatter = NumberFormat("#.##");
      double capitalInsoluto2D =
          double.parse(formatter.format(capitalInsoluto));
      double abono2D = double.parse(formatter.format(abonoTotal));
      double interes2D = double.parse(formatter.format(interesTotal));
      double amortizacion2D = double.parse(formatter.format(amortizacion));
      double saldoInsoluto2D = double.parse(formatter.format(saldoInsoluto));
      late DateTime nuevafecha;
//RESULTADO FIMAlES DEL PRESTAMO
      sumaTotal = abono2D * numeroPagos;
      CapitalTotal = CapitalTotal + amortizacion2D;
      sumaInteres = sumaTotal - CapitalTotal;

      sumaTotal2D = double.parse(formatter.format(sumaTotal));
      sumaInteres2D = double.parse(formatter.format(sumaInteres));
      CapitalTotal2D = double.parse(formatter.format(CapitalTotal));

      if (plazos.isCaseInsensitiveContains("diario")) {
        //
        nuevafecha = fechaPrestamo.add(Duration(days: index * 1));

        //
      }
      if (plazos.isCaseInsensitiveContains("semanal")) {
        //
        nuevafecha = fechaPrestamo.add(Duration(days: index * 7));

        //
      }
      if (plazos.isCaseInsensitiveContains("quincenal")) {
        //
        nuevafecha = fechaPrestamo.add(Duration(days: index * 15));

        //
      }
      if (plazos.isCaseInsensitiveContains("mensual")) {
        //
        nuevafecha = fechaPrestamo.add(Duration(days: index * 30));

        //
      }

      if (plazos.isCaseInsensitiveContains("catorcenal")) {
        //

        nuevafecha = fechaPrestamo.add(Duration(days: index * 14));

        //
      }

      dataRows.add(
        DataRow(
          cells: [
            DataCell(
              Center(
                  child: Text(
                "$index",
                style: TextStyle(
                  color: Constants.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            DataCell(Center(
              child: Text(nuevafecha
                  .toString()
                  .substring(0, 10)
                  .split("-")
                  .reversed
                  .join("/")),
            )),
            DataCell(
              Center(child: Text("\$ $capitalInsoluto2D")),
            ),
            DataCell(
              Center(child: Text("\$ $saldoInsoluto2D")),
            ),
            DataCell(
              Center(child: Text("\$ $interes2D")),
            ),
            DataCell(
              Center(child: Text("\$ $amortizacion2D")),
            ),
            DataCell(
              Center(
                  child: Text(
                "\$ $abono2D",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ],
        ),
      );
    }
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 30,
          pinned: true,
          backgroundColor: Colors.orange,
          elevation: 0.0,
          actions: [
            Container(
              height: 80,
              width: 70,
              child: Row(
                children: [
                  DataTable(
                    columnSpacing: 10,
                    dataRowHeight: 30,
                    headingRowHeight: 35,
                    headingRowColor:
                        MaterialStatePropertyAll(Colors.blueGrey.shade100),
                    columns: const [
                      DataColumn(
                        label: Text('NÚMERO DE PAGO'),
                      ),
                      DataColumn(
                        label: Text('FECHA DE PAGO'),
                      ),
                      DataColumn(
                        label: Text('CAPITAL INSOLUTO'),
                      ),
                      DataColumn(
                        label: Text('SALDO INSOLUTO'),
                      ),
                      DataColumn(
                        label: Text('INTERES'),
                      ),
                      DataColumn(
                        label: Text('CAPITAL'),
                      ),
                      DataColumn(
                        label: Text('PAGO TOTAL'),
                      ),
                    ],
                    rows: [],
                  ),
                ],
              ),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(
                      bottom: 5,
                      left: 5,
                      top: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                            text: "Capital \$ $CapitalTotal2D",
                            font: GoogleFonts.aldrich(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "Total interes \$ $sumaInteres2D",
                            font: GoogleFonts.aldrich(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "Monto total \$ $sumaTotal2D",
                            font: GoogleFonts.aldrich(
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 10,
                  dataRowHeight: 30,
                  headingRowHeight: 35,
                  headingRowColor: MaterialStatePropertyAll(Colors.transparent),
                  columns: const [
                    DataColumn(
                      label: Text(''),
                    ),
                    DataColumn(
                      label: Text(''),
                    ),
                    DataColumn(
                      label: Text(''),
                    ),
                    DataColumn(
                      label: Text(''),
                    ),
                    DataColumn(
                      label: Text(''),
                    ),
                    DataColumn(
                      label: Text(''),
                    ),
                    DataColumn(
                      label: Text(''),
                    ),
                  ],
                  rows: dataRows,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
