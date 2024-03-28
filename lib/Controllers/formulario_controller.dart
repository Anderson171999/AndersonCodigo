import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pagosplux/Models/formulario_models.dart';

class FormularioController {
  late GlobalKey<FormState> formKey;
  late FormularioModel _formularioModel;

  void inicializar() {
    formKey = GlobalKey<FormState>();
    _formularioModel = FormularioModel();
  }
  FormularioModel get formularioModel => _formularioModel;

  Future<void> enviar(BuildContext context) async {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      var url = 'https://apipre.pagoplux.com//intv1/integrations/getTransactionsEstablishmentResource';
      var usuario = 'o3NXHGmfujN3Tyzp1cyCDu3xst';
      var contrasena = 'TkBhZQP3zwMyx3JwC5HeFqzXM4p0jzsXp0hTbWRnI4riUtJT';
      var body = {
        "numeroIdentificacion": _formularioModel.identificacion,
        "initialDate": "2023-04-06",
        "finalDate": "2023-04-09",
        "tipoPago": "unico",
        "estado": "pagado",
        "identificacionCliente": _formularioModel.identificacion,
      };

      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Basic ' + base64Encode(utf8.encode('$usuario:$contrasena')),
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/historial_cobros');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Ocurrió un error al procesar el pago. Por favor, inténtalo de nuevo más tarde.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  bool _formularioValido() {
    return _formularioModel.nombre.isNotEmpty &&
        _formularioModel.telefono.isNotEmpty &&
        _formularioModel.direccion.isNotEmpty &&
        _formularioModel.correo.isNotEmpty &&
        _formularioModel.valorPago > 0 &&
        _formularioModel.identificacion.isNotEmpty;
  }
}
