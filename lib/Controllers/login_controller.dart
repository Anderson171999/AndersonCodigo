import 'package:flutter/material.dart';

class LoginController {
  void ingresar(String usuario, String contrasena, BuildContext context) {
    // Validar si el usuario y la contraseña son correctos
    if (usuario == 'Pagoplux' && contrasena == 'Pagoplux') {
      /* Navigator.pushNamed(context, '/formulario'); */
       Navigator.pushNamed(context, '/pago_plux');

      
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Usuario o contraseña incorrectos.'),
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
