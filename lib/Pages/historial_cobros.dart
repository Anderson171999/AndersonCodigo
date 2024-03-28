import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistorialCobrosPage extends StatefulWidget {
  @override
  _HistorialCobrosPageState createState() => _HistorialCobrosPageState();
}

class _HistorialCobrosPageState extends State<HistorialCobrosPage> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI(); // Llama a la función para obtener los datos cuando se carga la pantalla
    print(fetchDataFromAPI);
  }

  Future<void> fetchDataFromAPI() async {
    final apiUrl = 'https://apipre.pagoplux.com/intv1/integrations/getTransactionsEstablishmentResource'; // Reemplaza con la URL correcta para obtener los datos
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Map<String, dynamic>> newData = [];

      for (var item in responseData) {
        // Puedes mapear los datos recibidos a tu modelo de datos aquí
        newData.add({
          'name': item['name'],
          'paymentValue': item['paymentValue'],
          'date': item['date'],
        });
      }

      setState(() {
        data = newData;
      });
    } else {
      // Manejar el error de la solicitud HTTP aquí
      print('Error al cargar datos desde la API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Cobros'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Nombre')),
            DataColumn(label: Text('Valor de Pago')),
            DataColumn(label: Text('Fecha')),
          ],
          rows: data.map((item) {
            return DataRow(
              cells: [
                DataCell(Text(item['name'].toString())),
                DataCell(Text(item['paymentValue'].toString())),
                DataCell(Text(item['date'].toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
