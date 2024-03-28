import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pagosplux/Controllers/formulario_controller.dart';
import 'package:pagosplux/Pages/paybox.dart';

class FormularioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FormularioController _formularioController = FormularioController();
    _formularioController.inicializar();

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Formulario(controller: _formularioController),
      ),
    );
  }
}

class Formulario extends StatelessWidget {
  final FormularioController controller;

  const Formulario({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0) ,
            child: Container(
                     decoration: BoxDecoration(
                            color: const Color(0xffFEA1A1),
                            border: Border.all(color: const Color(0xffF9FBE7)),
                            borderRadius: BorderRadius.circular(15)),
              child: TextFormField(

                decoration: InputDecoration(labelText: 'Nombres*', border: InputBorder.none,labelStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
                onSaved: (value) => controller.formularioModel.nombre = value!,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0) ,
            child: Container(
                     decoration: BoxDecoration(
                            color: const Color(0xffFEA1A1),
                            border: Border.all(color: const Color(0xffF9FBE7)),
                            borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Número de teléfono*',border: InputBorder.none,labelStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu número de teléfono';
                  }
                  return null;
                },
                onSaved: (value) => controller.formularioModel.telefono = value!,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0) ,
            child: Container(
                     decoration: BoxDecoration(
                            color: const Color(0xffFEA1A1),
                            border: Border.all(color: const Color(0xffF9FBE7)),
                            borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Dirección*',border: InputBorder.none,labelStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu dirección';
                  }
                  return null;
                },
                onSaved: (value) => controller.formularioModel.direccion = value!,
                
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0) ,
            child: Container(
                     decoration: BoxDecoration(
                            color: const Color(0xffFEA1A1),
                            border: Border.all(color: const Color(0xffF9FBE7)),
                            borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Correo electrónico*',border: InputBorder.none,labelStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo electrónico';
                  }
                  if (!value.contains('@')) {
                    return 'Correo electrónico no válido';
                  }
                  return null;
                },
                onSaved: (value) => controller.formularioModel.correo = value!,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0) ,
            child: Container(
                     decoration: BoxDecoration(
                            color: const Color(0xffFEA1A1),
                            border: Border.all(color: const Color(0xffF9FBE7)),
                            borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Valor de pago*',border: InputBorder.none,labelStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el valor de pago';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Valor de pago inválido';
                  }
                  return null;
                },
                onSaved: (value) => controller.formularioModel.valorPago = double.parse(value!),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0) ,
            child: Container(
                     decoration: BoxDecoration(
                            color: const Color(0xffFEA1A1),
                            border: Border.all(color: const Color(0xffF9FBE7)),
                            borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Identificación*',border: InputBorder.none,labelStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu identificación';
                  }
                  return null;
                },
                onSaved: (value) => controller.formularioModel.identificacion = value!,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.enviar(context);
            },
            child: Text('Pagar'),
          ),





        ],
      ),
    );
  }
}
