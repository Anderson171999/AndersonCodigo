import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagosplux/Controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usuarioController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();
  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xffF9FBE7),
              Color(0xffF0EDD4),
              Color(0xffECCDB4),
              Color(0xffFEA1A1),
              Color(0xffD14D72),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 150,
                      color: Color(0xff89375F),
                    ),
                    Text(
                      'Bienvenido',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 48,
                        color: const Color(0xff89375F),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff89375F),
                        )),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFEA1A1),
                            border: Border.all(color: const Color(0xffF9FBE7)),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _usuarioController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Usuario',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFEA1A1),
                            border: Border.all(color: const Color(0xffF9FBE7)),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _contrasenaController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Contraseña',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          _loginController.ingresar(
                              _usuarioController.text,
                              _contrasenaController.text,
                              context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color(0xffB9375F),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Ingresar',
                              style: TextStyle(
                                color: Color(0xffF9FBE7),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
