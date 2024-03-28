import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:pagosplux/Models/pagoplux_model.dart';
import 'package:pagosplux/Models/response_model.dart';
import 'package:pagosplux/Pages/historial_cobros.dart';
import 'package:pagosplux/Pages/paybox.dart';
import 'package:http/http.dart' as http;

class PayboxDemoPage extends StatefulWidget {
  @override
  _PayboxDemoPageState createState() => _PayboxDemoPageState();
}

class _PayboxDemoPageState extends State<PayboxDemoPage> {
  late PagoPluxModel _paymentModelExample;
  String voucher = 'Pendiente Pago ';
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> data = [];

  TextEditingController nameController = new TextEditingController();
  String phoneNumber = '';
  TextEditingController _locationController = new TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _identificationController =
      TextEditingController();

  // Se construiye el view<
  Widget build(BuildContext context) {
    openPpx();
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
        actions: [],
      ),
      body: new SingleChildScrollView(
        child: Column(
          children: [
            Icon(
              Icons.assignment_returned_outlined,
              size: 130,
              color: Color.fromARGB(255, 9, 35, 4),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: formUI(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para el nuevo botón
                if (_formKey.currentState!.validate() &&
                    validatePhoneNumber(phoneNumber) == null) {
                  openPpx();
                  obtenerDatos(_paymentModelExample);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Por favor, complete todos los campos correctamente.'),
                    ),
                  );
                }
              },
              child: Text('Ver Tabla'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.payments_rounded),
        onPressed: () {
          // Validar el formulario antes de continuar
          if (_formKey.currentState!.validate() &&
              validatePhoneNumber(phoneNumber) == null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ModalPagoPluxView(
                  pagoPluxModel: _paymentModelExample,
                  onClose: obtenerDatos,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Por favor, complete todos los campos correctamente.'),
              ),
            );
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  //Formulario

  Widget formUI() {
    return Column(children: <Widget>[
      SizedBox(height: 10),
      Container(
        margin: EdgeInsets.only(top: 10.0),
        child: TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Color(0xFF18544B),
            ),
            contentPadding: EdgeInsets.all(15.0),
            filled: true,
            fillColor: Color.fromRGBO(142, 142, 147, 1.2),
            labelText: 'Nombres',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(40.0),
            ),
            labelStyle: new TextStyle(
                color: Color(0xFF18544B),
                fontSize: 15.0,
                fontWeight: FontWeight.normal),
          ),
          /* validator: validateName, */
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.0),
        child: _phoneInput(context),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.0),
        child: TextFormField(
          controller: _locationController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.location_on,
              color: Color(0xFF18544B),
            ),
            contentPadding: EdgeInsets.all(15.0),
            filled: true,
            fillColor: Color.fromRGBO(142, 142, 147, 1.2),
            labelText: 'Dirección',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(40.0),
            ),
            labelStyle: new TextStyle(
                color: Color(0xFF18544B),
                fontSize: 15.0,
                fontWeight: FontWeight.normal),
          ),
          /* validator: validateDirection, */
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.0),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.email, color: Color(0xFF18544B)),
              contentPadding: EdgeInsets.all(15.0),
              filled: true,
              fillColor: Color.fromRGBO(142, 142, 147, 1.2),
              labelText: "Correo electrónico",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(40.0),
              ),
              labelStyle: new TextStyle(
                  color: Color(0xFF18544B),
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal)),
          controller: _emailController,
          /* validator: (value) =>
              !validateEmail(value!) ? "El email es obligatorio*" : null, */
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.0),
        child: TextFormField(
          keyboardType: TextInputType.numberWithOptions(
              decimal: true), // Permite números decimales
          inputFormatters: [
            DecimalTextInputFormatter(), // Usa el TextInputFormatter personalizado
          ],
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.request_page_outlined, color: Color(0xFF18544B)),
            contentPadding: EdgeInsets.all(15.0),
            filled: true,
            fillColor: Color.fromRGBO(142, 142, 147, 1.2),
            labelText: "Valor de pago",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(40.0),
            ),
            labelStyle: new TextStyle(
              color: Color(0xFF18544B),
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          controller: _paymentController,
          /* validator: (value) =>
              value!.isEmpty ? "El valor de pago es obligatorio*" : null, */
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.0),
        child: TextFormField(
          keyboardType:
              TextInputType.numberWithOptions(), // Cambia el tipo de teclado
          inputFormatters: [
            LengthLimitingTextInputFormatter(
                10), // Limita la entrada a 10 caracteres
            CedulaTextInputFormatter(), // Usa el TextInputFormatter personalizado
          ],
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.credit_card, color: Color(0xFF18544B)),
            contentPadding: EdgeInsets.all(15.0),
            filled: true,
            fillColor: Color.fromRGBO(142, 142, 147, 1.2),
            labelText: "Número de Cédula",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(40.0),
            ),
            labelStyle: TextStyle(
              color: Color(0xFF18544B),
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          controller: _identificationController,
          /* validator: (value) =>
              value!.isEmpty ? "El número de cédula es obligatorio*" : null, */
        ),
      ),
    ]);
  }

  /*
   * Se encarga de iniciar los datos para el proceso de pago
   */
  openPpx() {
    print('Se habre el botón de pagos');
    this._paymentModelExample = new PagoPluxModel();
    this._paymentModelExample.payboxRemail = 'contactanos@pagoplux.com';
    this._paymentModelExample.payboxEnvironment = 'sandbox';
    this._paymentModelExample.payboxProduction = true;
    this._paymentModelExample.payboxBase0 = 4.00;
    this._paymentModelExample.payboxBase12 = 8;
    this._paymentModelExample.payboxSendname = 'Gerardo';
    this._paymentModelExample.payboxSendmail = 'cristian.bastidas@aol.com';
    this._paymentModelExample.payboxRename = 'KrugerShop';
    this._paymentModelExample.PayboxDirection = 'Bolivar';
    this._paymentModelExample.payboxDescription = 'Pago desde Flutter';

    this._paymentModelExample.payboxClientName = nameController.text;
    this._paymentModelExample.payboxClientPhone = phoneNumber;
    this._paymentModelExample.payboxDirection = _locationController.text;
    this._paymentModelExample.payboxSendEmail = _emailController.text;
    this._paymentModelExample.payboxPaymentValue = _paymentController.text;

    this._paymentModelExample.payboxClientIdentification =
        _identificationController.text;
  }

  Widget crearTop(BuildContext context) {
    return Container(height: 0);
  }

obtenerDatos(PagoPluxModel datos) async {
  // Realizar la llamada al API para obtener el historial de cobros
  final apiUrl = 'https://apipre.pagoplux.com/intv1/integrations/getTransactionsEstablishmentResource';
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Basic ' + base64Encode(utf8.encode('o3NXHGmfujN3Tyzp1cyCDu3xst:TkBhZQP3zwMyx3JwC5HeFqzXM4p0jzsXp0hTbWRnI4riUtJT')),
    },
    body: jsonEncode({
      "numeroIdentificacion": "0992664673001",
      "initialDate": "2023-04-06",
      "finalDate": "2023-04-09",
      "tipoPago": "unico",
      "estado": "pagado",
      "identificacionCliente": datos.payboxClientIdentification,
    }),
  );

if (response.statusCode == 200) {
  final dynamic responseData = jsonDecode(response.body);

  if (responseData is Map<String, dynamic>) {
    // Procesar los datos como un objeto JSON aquí
    // Dependiendo de la estructura de tus datos, podrías acceder a ellos directamente
    // o iterar sobre las claves del objeto para extraer los datos necesarios.
    
    // Ejemplo de acceso directo a datos:
    final name = responseData['name'];
    final paymentValue = responseData['paymentValue'];
    final date = responseData['date'];

    // Crear una lista con los datos obtenidos
    final List<Map<String, dynamic>> newData = [
      {
        'name': name,
        'paymentValue': paymentValue,
        'date': date,
      }
    ];

    // Actualizar el estado con los nuevos datos del historial de cobros
    setState(() {
      data = newData;
    });

    // Después de obtener los datos del pago exitoso, navega a la pantalla de historial de cobros
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistorialCobrosPage(),
      ),
    );
  } else {
    print('La respuesta de la API no es un objeto JSON.');
  }
} else {
  // Manejar el error de la solicitud HTTP aquí
  print('Error al cargar datos desde la API');
}



}


  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  String? validateName(String? value) {
    String pattern = r'(^[a-zA-ZñÑ ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return "El nombre es obligatorio*";
    } else if (!regExp.hasMatch(value!)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  String? validateDirection(String? value) {
    String pattern = r'(^[a-zA-ZñÑ ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return "La direción es obligatorio*";
    }
    return null;
  }

  String? validatePasswordM(String? value) {
    String pattern =
        r'(^(?=(?:.*\d){1})(?=(?:.*[A-Z]){1})(?=(?:.*[a-z]){2})\S{8,}$)';
    RegExp regExp = new RegExp(pattern);
    if (value!.length <= 8) {
      return "Debe tener minimo 8 caracteres";
    } else if (!regExp.hasMatch(value)) {
      return "La Password Mayusculas, Minusculas y Numeros";
    }
    return null;
  }

  bool validatePayment(String email) {
    return RegExp("").hasMatch(email);
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "El número de teléfono es obligatorio*";
    }
    return null;
  }

  Widget _phoneInput(BuildContext context) {
    return IntlPhoneField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15.0),
          filled: true,
          fillColor: Color.fromRGBO(142, 142, 147, 1.2),
          labelText: 'Ingresar celular',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30.0),
          ),
          labelStyle: new TextStyle(
              color: Color(0xFF18544B),
              fontSize: 15.0,
              fontWeight: FontWeight.normal),
        ),
        initialCountryCode: 'EC',
        disableLengthCheck: true,
        searchText: 'Buscar país',
        onChanged: (phone) {
          phoneNumber = phone.completeNumber;
        });
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Utiliza una expresión regular para permitir solo números y un punto
    final regExp = RegExp(r'^\d*\.?\d{0,2}');
    String newText = regExp.stringMatch(newValue.text) ?? '';

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class CedulaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Utiliza una expresión regular para permitir solo números
    final regExp = RegExp(r'^\d*$');
    String newText = regExp.stringMatch(newValue.text) ?? '';

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
