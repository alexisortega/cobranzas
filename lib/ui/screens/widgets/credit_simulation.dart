import 'dart:math';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/ui/screens/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class CreditSimulation extends StatefulWidget {
  final int? numeroPagos;
  final String plazos;
  final double montoSolicitado;
  final DateTime fechaPrestamo;
  final double interesAsignado;

  const CreditSimulation({
    super.key,
    required this.numeroPagos,
    required this.plazos,
    required this.montoSolicitado,
    required this.fechaPrestamo,
    required this.interesAsignado,
  });

  @override
  State<CreditSimulation> createState() => _CreditSimulationState();
}

class _CreditSimulationState extends State<CreditSimulation> {
  // static var controllerClientes4 = Get.put(clientsController());

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
                      Expanded(child: Container()),
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
  int numeroPagos,
  DateTime fechaPrestamo,
  String plazos,
  double montoPrestamo,
  double tasaInteres,
) {
  List<DataRow> dataRows = [];
  double interesperiodoPlazo = 0.0;
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
  print.printInfo(info: "Tasa de interes anual: $tasaInteres");

  if (plazos.toString().isCaseInsensitiveContains("diario")) {
    interesperiodoPlazo = tasaInteres / 365;
    cuotaPlazo = montoPrestamo *
        interesperiodoPlazo /
        (1 - pow(1 + interesperiodoPlazo, -numeroPagos));

    print.printInfo(info: "interes periodo diario " "$interesperiodoPlazo");
    print.printInfo(info: "Cuota diario $cuotaPlazo ");
  }
  if (plazos.toString().isCaseInsensitiveContains("semanal")) {
    interesperiodoPlazo = tasaInteres / 52;
    cuotaPlazo = montoPrestamo *
        interesperiodoPlazo /
        (1 - pow(1 + interesperiodoPlazo, -numeroPagos));

    print.printInfo(info: "interes periodo semanal " "$interesperiodoPlazo");
    print.printInfo(info: "Cuota semanal $cuotaPlazo ");
  } else if (plazos.toString().isCaseInsensitiveContains("catorcenal")) {
    interesperiodoPlazo = tasaInteres / 26;
    cuotaPlazo = montoPrestamo *
        interesperiodoPlazo /
        (1 - pow(1 + interesperiodoPlazo, -numeroPagos));

    print.printInfo(info: "interes periodo catorcenal " "$interesperiodoPlazo");
    print.printInfo(info: "Cuota catorcenal $cuotaPlazo ");
  } else if (plazos.toString().isCaseInsensitiveContains("quincenal")) {
    interesperiodoPlazo = tasaInteres / 12;
    cuotaPlazo = montoPrestamo *
        interesperiodoPlazo /
        (1 - pow(1 + interesperiodoPlazo, -numeroPagos));

    print.printInfo(info: "interes periodo quincenal " "$interesperiodoPlazo");
    print.printInfo(info: "Cuota quincenal $cuotaPlazo ");
  } else if (plazos.toString().isCaseInsensitiveContains("mensual")) {
    interesperiodoPlazo = tasaInteres / 12;
    cuotaPlazo = montoPrestamo *
        interesperiodoPlazo /
        (1 - pow(1 + interesperiodoPlazo, -numeroPagos));

    print.printInfo(info: "interes periodo mensual " "$interesperiodoPlazo");
    print.printInfo(info: "Cuota mensual $cuotaPlazo ");
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

    interesTotal = capitalInsoluto * interesperiodoPlazo;
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
    sumaTotal = abono2D * numeroPagos;
    capitalTotal = capitalTotal + amortizacion2D;
    sumaInteres = sumaTotal - capitalTotal;

    sumaTotal2D = double.parse(formatter.format(sumaTotal));
    sumaInteres2D = double.parse(formatter.format(sumaInteres));
    capitalTotal2D = double.parse(formatter.format(capitalTotal));

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
