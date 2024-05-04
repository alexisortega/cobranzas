import 'dart:math';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: depend_on_referenced_packages

class CreditPayments extends StatefulWidget {
  //datos del prestamo
  final int numeroPagos;
  final String plazos;
  final double montoSolicitado;
  final DateTime fechaPrestamo;
  final double interesAsignado;
  //datos de credito
  final String codigoCredito;
  final String propietarioCredito;
  final List<String>? diasSemana;
  //datos del cliente
  final String codigoCliente;

  const CreditPayments({
    super.key,
    //datos de credito
    required this.codigoCredito,
    required this.propietarioCredito,
    required this.diasSemana,

    //datos del prestamo
    required this.numeroPagos,
    required this.plazos,
    required this.montoSolicitado,
    required this.fechaPrestamo,
    required this.interesAsignado,
    required this.codigoCliente,
  });

  @override
  State<CreditPayments> createState() => _CreditPaymentsState();
}

class _CreditPaymentsState extends State<CreditPayments> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    /* final Stream<DocumentSnapshot> clienteStream = FirebaseFirestore.instance
        .collection('clientes')
        .doc(widget.codigo_cliente)
        .snapshots(); */

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
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: const Offset(10, 10),
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
                widget.numeroPagos,
                widget.fechaPrestamo,
                widget.plazos,
                widget.montoSolicitado,
                widget.interesAsignado,
              )),
          const SizedBox(
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
                        child: const Text("Generar PDF")),
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
    double interesPeriodoPlazo = 0.0;
    double cuotaPlazo = 0.0;
    double capitalInsoluto = montoPrestamo;
    double saldoInsoluto;
    double abonoTotal;
    double interesTotal;
    double amortizacion;
    double sumaTotal = 0.0;
    double sumaInteres = 0.0;
    double capitalTotal = 0.0;

    double sumaTotal2D = 0.0;
    double sumaInteres2D = 0.0;
    double capitalTotal2D = 0.0;

    tasaInteres = tasaInteres / 100;
    printInfo(info: "Tasa de interes anual: $tasaInteres");

    if (plazos.toString().isCaseInsensitiveContains("diario")) {
      interesPeriodoPlazo = tasaInteres / 365;
      cuotaPlazo = montoPrestamo *
          interesPeriodoPlazo /
          (1 - pow(1 + interesPeriodoPlazo, -numeroPagos));

      printInfo(info: "interes periodo diario " "$interesPeriodoPlazo");
      printInfo(info: "Cuota diario $cuotaPlazo ");
    }
    if (plazos.toString().isCaseInsensitiveContains("semanal")) {
      interesPeriodoPlazo = tasaInteres / 52;
      cuotaPlazo = montoPrestamo *
          interesPeriodoPlazo /
          (1 - pow(1 + interesPeriodoPlazo, -numeroPagos));

      printInfo(info: "interes periodo semanal " "$interesPeriodoPlazo");
      printInfo(info: "Cuota semanal $cuotaPlazo ");
    } else if (plazos.toString().isCaseInsensitiveContains("catorcenal")) {
      interesPeriodoPlazo = tasaInteres / 26;
      cuotaPlazo = montoPrestamo *
          interesPeriodoPlazo /
          (1 - pow(1 + interesPeriodoPlazo, -numeroPagos));

      printInfo(info: "interes periodo catorcenal " "$interesPeriodoPlazo");
      printInfo(info: "Cuota catorcenal $cuotaPlazo ");
    } else if (plazos.toString().isCaseInsensitiveContains("quincenal")) {
      interesPeriodoPlazo = tasaInteres / 12;
      cuotaPlazo = montoPrestamo *
          interesPeriodoPlazo /
          (1 - pow(1 + interesPeriodoPlazo, -numeroPagos));

      printInfo(info: "interes periodo quincenal " "$interesPeriodoPlazo");
      printInfo(info: "Cuota quincenal $cuotaPlazo ");
    } else if (plazos.toString().isCaseInsensitiveContains("mensual")) {
      interesPeriodoPlazo = tasaInteres / 12;
      cuotaPlazo = montoPrestamo *
          interesPeriodoPlazo /
          (1 - pow(1 + interesPeriodoPlazo, -numeroPagos));

      printInfo(info: "interes periodo mensual " "$interesPeriodoPlazo");
      printInfo(info: "Cuota mensual $cuotaPlazo ");
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

      interesTotal = capitalInsoluto * interesPeriodoPlazo;
      amortizacion = abonoTotal - interesTotal;
      saldoInsoluto = saldoInsoluto - amortizacion;

      double capitalInsoluto2D = double.parse(capitalInsoluto.toString());
      double abono2D = double.parse(abonoTotal.toString());
      double interes2D = double.parse(interesTotal.toString());
      double amortizacion2D = double.parse(amortizacion.toString());
      double saldoInsoluto2D = double.parse(saldoInsoluto.toString());
      late DateTime nuevafecha;
//RESULTADO FIMAlES DEL PRESTAMO
      sumaTotal = abono2D * numeroPagos;
      capitalTotal = capitalTotal + amortizacion2D;
      sumaInteres = sumaTotal - capitalTotal;

      sumaTotal2D = double.parse(sumaTotal.toString());
      sumaInteres2D = double.parse(sumaInteres.toString());
      capitalTotal2D = double.parse(capitalTotal.toString());

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
            SizedBox(
              height: 80,
              width: 70,
              child: Row(
                children: [
                  DataTable(
                    columnSpacing: 10,
                    // ignore: deprecated_member_use
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
                    rows: const [],
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
                            text: "Capital \$ $capitalTotal2D",
                            font: const TextStyle()),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "Total interes \$ $sumaInteres2D",
                            font: const TextStyle()),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "Monto total \$ $sumaTotal2D",
                            font: const TextStyle()),
                      ],
                    )),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 10,
                  // ignore: deprecated_member_use
                  dataRowHeight: 30,
                  headingRowHeight: 35,
                  headingRowColor:
                      const MaterialStatePropertyAll(Colors.transparent),
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
