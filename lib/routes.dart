import 'package:flutter/material.dart';
import 'package:pagosplux/Models/pagoplux_model.dart';
import 'package:pagosplux/Pages/formulario_page.dart';
import 'package:pagosplux/Pages/historial_cobros.dart';
import 'package:pagosplux/Pages/login_page.dart';
import 'package:pagosplux/Pages/paybox.dart';
import 'package:pagosplux/Pages/payboxCobros.dart';

class Routes {

  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => LoginPage(),
    '/formulario': (context) => FormularioPage(),
    '/historial_cobros': (context) => HistorialCobrosPage(),
    '/pago_plux': (context) => PayboxDemoPage(),
  };
}
