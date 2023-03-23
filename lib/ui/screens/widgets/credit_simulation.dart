import 'dart:math';
import 'package:cobranzas/constants.dart';
import 'package:cobranzas/controllers/clients_Controller.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class creditSimulation extends StatefulWidget {
  final int? numero_pagos;
  final String plazos;
  final double monto_solicitado;
  final DateTime fecha_prestamo;
  final double interes_asignado;

  const creditSimulation({
    super.key,
    required this.numero_pagos,
    required this.plazos,
    required this.monto_solicitado,
    required this.fecha_prestamo,
    required this.interes_asignado,
  });

  @override
  State<creditSimulation> createState() => _creditSimulationState();
}

class _creditSimulationState extends State<creditSimulation> {
  static var controllerClientes4 = Get.put(clientsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Constants.blueColor,
            title: const Text(
              'Simulación de crédito',
              textAlign: TextAlign.center,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 10, right: 10, bottom: 10),
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      height: size.height,
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50.0,
                            child: Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 40.0,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "$widget",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            "ID: 052020",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 10, right: 10, bottom: 10),
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                            child: paymentNumberList(
                          widget.numero_pagos!,
                          widget.fecha_prestamo,
                          widget.plazos,
                          widget.monto_solicitado,
                          widget.interes_asignado,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

paymentNumberList(
  int numero_pagos,
  DateTime fecha_prestamo,
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
        (1 - pow(1 + InteresperiodoPlazo, -numero_pagos));

    print("interes periodo diario " + "$InteresperiodoPlazo");
    print("Cuota diario $cuotaPlazo ");
  }
  if (plazos.toString().isCaseInsensitiveContains("semanal")) {
    InteresperiodoPlazo = tasaInteres / 52;
    cuotaPlazo = montoPrestamo *
        InteresperiodoPlazo /
        (1 - pow(1 + InteresperiodoPlazo, -numero_pagos));

    print("interes periodo semanal " + "$InteresperiodoPlazo");
    print("Cuota semanal $cuotaPlazo ");
  } else if (plazos.toString().isCaseInsensitiveContains("catorcenal")) {
    InteresperiodoPlazo = tasaInteres / 26;
    cuotaPlazo = montoPrestamo *
        InteresperiodoPlazo /
        (1 - pow(1 + InteresperiodoPlazo, -numero_pagos));

    print("interes periodo catorcenal " + "$InteresperiodoPlazo");
    print("Cuota catorcenal $cuotaPlazo ");
  } else if (plazos.toString().isCaseInsensitiveContains("quincenal")) {
    InteresperiodoPlazo = tasaInteres / 12;
    cuotaPlazo = montoPrestamo *
        InteresperiodoPlazo /
        (1 - pow(1 + InteresperiodoPlazo, -numero_pagos));

    print("interes periodo quincenal " + "$InteresperiodoPlazo");
    print("Cuota quincenal $cuotaPlazo ");
  } else if (plazos.toString().isCaseInsensitiveContains("mensual")) {
    InteresperiodoPlazo = tasaInteres / 12;
    cuotaPlazo = montoPrestamo *
        InteresperiodoPlazo /
        (1 - pow(1 + InteresperiodoPlazo, -numero_pagos));

    print("interes periodo mensual " + "$InteresperiodoPlazo");
    print("Cuota mensual $cuotaPlazo ");
  }
  saldoInsoluto = montoPrestamo;
  amortizacion = 0.0;
  for (var i = 0; i < numero_pagos; i++) {
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
    double capitalInsoluto2D = double.parse(formatter.format(capitalInsoluto));
    double abono2D = double.parse(formatter.format(abonoTotal));
    double interes2D = double.parse(formatter.format(interesTotal));
    double amortizacion2D = double.parse(formatter.format(amortizacion));
    double saldoInsoluto2D = double.parse(formatter.format(saldoInsoluto));
    late DateTime nuevafecha;
//RESULTADO FIMAlES DEL PRESTAMO
    sumaTotal = abono2D * numero_pagos;
    CapitalTotal = CapitalTotal + amortizacion2D;
    sumaInteres = sumaTotal - CapitalTotal;

    sumaTotal2D = double.parse(formatter.format(sumaTotal));
    sumaInteres2D = double.parse(formatter.format(sumaInteres));
    CapitalTotal2D = double.parse(formatter.format(CapitalTotal));

    if (plazos.isCaseInsensitiveContains("diario")) {
      //
      nuevafecha = fecha_prestamo.add(Duration(days: index * 1));

      //
    }
    if (plazos.isCaseInsensitiveContains("semanal")) {
      //
      nuevafecha = fecha_prestamo.add(Duration(days: index * 7));

      //
    }
    if (plazos.isCaseInsensitiveContains("quincenal")) {
      //
      nuevafecha = fecha_prestamo.add(Duration(days: index * 15));

      //
    }
    if (plazos.isCaseInsensitiveContains("mensual")) {
      //
      nuevafecha = fecha_prestamo.add(Duration(days: index * 30));

      //
    }

    if (plazos.isCaseInsensitiveContains("catorcenal")) {
      //

      nuevafecha = fecha_prestamo.add(Duration(days: index * 14));

      //
    }

    dataRows.add(
      DataRow(
        cells: [
          DataCell(
            Center(
                child: Text(
              "${index}",
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
                          text: "Capital \$ ${CapitalTotal2D}",
                          font:
                              GoogleFonts.aldrich(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomText(
                          text: "Total interes \$ $sumaInteres2D",
                          font:
                              GoogleFonts.aldrich(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomText(
                          text: "Monto total \$ $sumaTotal2D",
                          font:
                              GoogleFonts.aldrich(fontWeight: FontWeight.bold)),
                    ],
                  )),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: const MaterialStatePropertyAll(Colors.orange),
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
                rows: dataRows,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
