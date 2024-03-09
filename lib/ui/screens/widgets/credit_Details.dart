// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/models/constants.dart';
import 'package:cobranzas/ui/screens/widgets/payments.dart';
import 'package:cobranzas/ui/screens/widgets/customer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class CreditDetails extends StatefulWidget {
  final String codigoCredito;
  final double montoSolicitado;
  final double interesAsignado;
  final String diasSemana;
  final Timestamp fechaPrestamo;
  final int numeroPagos;
  final String plazos;
  final String propietarioCredito;
  final String status;

  const CreditDetails({
    super.key,
    required this.codigoCredito,
    required this.montoSolicitado,
    required this.interesAsignado,
    required this.diasSemana,
    required this.fechaPrestamo,
    required this.numeroPagos,
    required this.plazos,
    required this.propietarioCredito,
    required this.status,
  });

  @override
  State<CreditDetails> createState() => _CreditDetailsState();
}

class _CreditDetailsState extends State<CreditDetails> {
  List<Pago> pagos = [
    Pago(
        mes: 'Enero 2022',
        monto: '\$250',
        fechaPago: '01/01/2022',
        estado: 'Pagado'),
    Pago(
        mes: 'Febrero 2022',
        monto: '\$250',
        fechaPago: '01/02/2022',
        estado: 'Pagado'),
    Pago(
        mes: 'Marzo 2022',
        monto: '\$250',
        fechaPago: '01/03/2022',
        estado: 'Pagado'),
    Pago(
        mes: 'Marzo 2022',
        monto: '\$250',
        fechaPago: '01/03/2022',
        estado: 'Pendiente'),
    Pago(
        mes: 'Marzo 2022',
        monto: '\$250',
        fechaPago: '01/03/2022',
        estado: 'Pendiente'),
    Pago(
        mes: 'Marzo 2022',
        monto: '\$250',
        fechaPago: '01/03/2022',
        estado: 'Pendiente'),
  ];
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Constants.blueColor,
          title: const Text(
            "Detalle de crédito",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Constants.orangeColor,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Información del préstamo',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          const Text(
                            'Folio del crédito:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            widget.codigoCredito,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Monto del préstamo'),
                                  const SizedBox(height: 5),
                                  Text(
                                    '\$ ${widget.montoSolicitado}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Tasa de interés anual'),
                                const SizedBox(height: 5),
                                Text('${widget.interesAsignado} %',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Duración del préstamo'),
                                const SizedBox(height: 5),
                                Text(
                                    '${widget.numeroPagos} ${tipoPlazo(widget.plazos)}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        color: Colors.transparent,
                        child: Row(children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Monto total a pagar'),
                                const SizedBox(height: 5),
                                Text(
                                    '${(widget.montoSolicitado) + (widget.interesAsignado / 100)} ',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('interés por periodo'),
                                const SizedBox(height: 5),
                                Text(
                                    "${interesPorPeriodo(
                                      widget.plazos,
                                      widget.interesAsignado,
                                    )} %",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Tipo de periodo'),
                                const SizedBox(height: 5),
                                Text(widget.plazos,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                        ])),
                    const SizedBox(height: 20),
                    const Text(
                      'Estado del préstamo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Estado actual'),
                              const SizedBox(height: 5),
                              Text(
                                widget.status,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Primer Pago'),
                              const SizedBox(height: 5),
                              Text(
                                primerPago(widget.fechaPrestamo, widget.plazos)
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Proximo pago'),
                              SizedBox(height: 5),
                              Text(
                                '01/04/2022',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ultimo Pago'),
                              SizedBox(height: 5),
                              Text(
                                '01/04/2022',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Propietario del crédito :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                widget.propietarioCredito,
                                style: TextStyle(
                                    color: Constants.blueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              inherit: false),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                duration: const Duration(
                                                    milliseconds: 780),
                                                child: customerView(
                                                    cont: 1,
                                                    datos: List.empty(),
                                                    codigoCliente: "22",
                                                    nombre: "alex",
                                                    apellidoP: "juares",
                                                    apellidoM: "juarez",
                                                    genero: "Hombre",
                                                    curp: "AOBA950530HHGRDL04",
                                                    calle: "VENUS",
                                                    colonia: "ALFREDO",
                                                    municipioDelegacion:
                                                        "TLANALAPA",
                                                    estado: "HIDALGO",
                                                    codigoPostal: 43930,
                                                    numeroTel: 7751208021,
                                                    fechaNacimiento:
                                                        DateTime.now()
                                                            .toString(),
                                                    urlFoto:
                                                        "https://firebasestorage.googleapis.com/v0/b/gestorcobranza-721b0.appspot.com/o/images%2F1675295357788?alt=media&token=f2d7e553-beb8-4404-bda7-f65604341fa7"),
                                                type: PageTransitionType
                                                    .bottomToTop,
                                              ));
                                        },
                                        icon: const Icon(Icons.person_pin_sharp,
                                            color: Colors.white),
                                        label: const Text(
                                          "Información del cliente",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red[400],
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              inherit: false),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          //PAGINA PAGOS
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: const PaymentScreen(),
                                                  type: PageTransitionType
                                                      .bottomToTop));
                                        },
                                        icon: const Icon(Icons.payment,
                                            color: Colors.black),
                                        label: const Text(
                                          "Pagar",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Historial de pagos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                        color: Colors.transparent,
                        width: 700,
                        height: 350,
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  Table(
                                    border: TableBorder.all(),
                                    children: [
                                      TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300]),
                                        children: const [
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Text(
                                                'Mes',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Text(
                                                'Pago',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Text(
                                                'Fecha de pago',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Text(
                                                'Estado',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ...pagos.map((pago) {
                                        return TableRow(
                                          children: [
                                            TableCell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(pago.mes),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(pago.monto),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(pago.fechaPago),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(
                                                  pago.estado,
                                                  style: TextStyle(
                                                      color: pago.estado ==
                                                              'Pagado'
                                                          ? Colors.green
                                                          : Colors.red),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
             /* .toList()  se comento sugerencia  */ }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                  ])),
        ));
  }

  primerPago(Timestamp fechaPrestamo, String plazo) {
    DateTime primerPago = fechaPrestamo.toDate();
    DateTime nuevafecha;
    String mostrarfecha;
    if (plazo.isCaseInsensitiveContains("diario")) {
      nuevafecha = primerPago.add(const Duration(days: 1));
      mostrarfecha =
          nuevafecha.toString().substring(0, 10).split("-").reversed.join("/");
      return mostrarfecha;
    } else if (plazo.isCaseInsensitiveContains("semanal")) {
      nuevafecha = primerPago.add(const Duration(days: 7));
      mostrarfecha =
          nuevafecha.toString().substring(0, 10).split("-").reversed.join("/");
      return mostrarfecha;
    } else if (plazo.isCaseInsensitiveContains("catorcenal")) {
      nuevafecha = primerPago.add(const Duration(days: 14));
      mostrarfecha =
          nuevafecha.toString().substring(0, 10).split("-").reversed.join("/");
      return mostrarfecha;
    } else if (plazo.isCaseInsensitiveContains("quincenal")) {
      nuevafecha = primerPago.add(const Duration(days: 15));
      mostrarfecha =
          nuevafecha.toString().substring(0, 10).split("-").reversed.join("/");
      return mostrarfecha;
    } else if (plazo.isCaseInsensitiveContains("mensual")) {
      nuevafecha = primerPago.add(const Duration(days: 30));
      mostrarfecha =
          nuevafecha.toString().substring(0, 10).split("-").reversed.join("/");
      return mostrarfecha;
    } else {
      return;
    }
  }

  tipoPlazo(String plazo) {
    if (plazo.isCaseInsensitiveContains("diario")) {
      return "Días";
    } else if (plazo.isCaseInsensitiveContains("semanal")) {
      return "Semanas";
    } else if (plazo.isCaseInsensitiveContains("catorcenal")) {
      return "Catorcenas";
    } else if (plazo.isCaseInsensitiveContains("quincenal")) {
      return "Quincenas";
    } else if (plazo.isCaseInsensitiveContains("mensual")) {
      return "Meses";
    } else {
      return "Plazos";
    }
  }

  String interesPorPeriodo(String plazo, double interesAsignado) {
    late double interesPeriodo;
    late String resultado;
    if (plazo.isCaseInsensitiveContains("diario")) {
      interesPeriodo = interesAsignado / 365;
      resultado = interesPeriodo.toStringAsFixed(2);
      return resultado;
    } else if (plazo.isCaseInsensitiveContains("semanal")) {
      interesPeriodo = interesAsignado / 52;
      resultado = interesPeriodo.toStringAsFixed(2);
      return resultado;
    } else if (plazo.isCaseInsensitiveContains("catorcenal")) {
      interesPeriodo = interesAsignado / 26;
      resultado = interesPeriodo.toStringAsFixed(2);
      return resultado;
    } else if (plazo.isCaseInsensitiveContains("quincenal")) {
      interesPeriodo = interesAsignado / 24;

      return interesPeriodo.toString();
    } else if (plazo.isCaseInsensitiveContains("mensual")) {
      interesPeriodo = interesAsignado / 12;
      resultado = interesPeriodo.toStringAsFixed(2);
      return resultado;
    } else {
      return "Plazos";
    }
  }
}

class Pago {
  final String mes;
  final String monto;
  final String fechaPago;
  final String estado;

  Pago(
      {required this.mes,
      required this.monto,
      required this.fechaPago,
      required this.estado});
}
