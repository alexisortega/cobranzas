// ignore_for_file: library_private_types_in_public_api, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobranzas/constants.dart';
import 'package:cobranzas/ui/screens/widgets/Payments.dart';
import 'package:cobranzas/ui/screens/widgets/customer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class creditDetails extends StatefulWidget {
  String codigo_credito;
  double monto_solicitado;
  double interes_asignado;
  String dias_semana;
  Timestamp fecha_prestamo;
  int numero_pagos;
  String plazos;
  String propietario_credito;
  String status;

  creditDetails({
    super.key,
    required this.codigo_credito,
    required this.monto_solicitado,
    required this.interes_asignado,
    required this.dias_semana,
    required this.fecha_prestamo,
    required this.numero_pagos,
    required this.plazos,
    required this.propietario_credito,
    required this.status,
  });

  @override
  State<creditDetails> createState() => _creditDetailsState();
}

class _creditDetailsState extends State<creditDetails> {
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
    Size size = MediaQuery.of(context).size;
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
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
                            "${widget.codigo_credito}",
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
                                    '\$ ${widget.monto_solicitado}',
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
                                Text('${widget.interes_asignado} %',
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
                                    '${widget.numero_pagos} ${TipoPlazo(widget.plazos)}',
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        color: Colors.transparent,
                        child: Row(children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Monto total a pagar'),
                                SizedBox(height: 5),
                                Text(
                                    '${(widget.monto_solicitado) + (widget.interes_asignado / 100)} ',
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
                                SizedBox(height: 5),
                                Text(
                                    "${interesPorPeriodo(
                                      widget.plazos,
                                      widget.interes_asignado,
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
                                Text('${widget.plazos}',
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
                            children: const [
                              Text('Estado actual'),
                              SizedBox(height: 5),
                              Text(
                                'Actualizado',
                                style: TextStyle(
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
                            children: const [
                              Text('Primer Pago'),
                              SizedBox(height: 5),
                              Text(
                                '01/04/2022',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
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
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
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
                                "${widget.propietario_credito}",
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
                                          primary: Colors.blue,
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
                                                    codigo_cliente: "22",
                                                    nombre: "alex",
                                                    apellido_p: "juares",
                                                    apellido_m: "juarez",
                                                    genero: "Hombre",
                                                    curp: "AOBA950530HHGRDL04",
                                                    calle: "VENUS",
                                                    colonia: "ALFREDO",
                                                    municipio_delegacion:
                                                        "TLANALAPA",
                                                    estado: "HIDALGO",
                                                    codigo_postal: 43930,
                                                    numero_tel: 7751208021,
                                                    fecha_nacimiento:
                                                        DateTime.now(),
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red[400],
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
                                                  child: PaymentScreen(),
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
                                      }).toList(),
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

  TipoPlazo(String plazo) {
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