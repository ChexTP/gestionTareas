import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gestion_tareas/utils/auth_service.dart';
import 'package:gestion_tareas/widgets/input_form_builder.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = 'homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion de Tareas',
            style:
                const TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400)),
        backgroundColor: const Color(0xFF83bde5),
        toolbarHeight: 80.0,
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut(context);
              },
              icon: Icon(
                Icons.logout_sharp,
                size: 40,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              Container(
                  
                  width: 600,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: FormBuilder(
                          key: _formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Ingresa una tarea nueva',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.0,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                InputForm(
                                  name: 'email',
                                  obscureText: false,
                                  hintText: 'Ingresa el nombre de la tarea',
                                  icon: Icons.title,
                                  borderColor: const Color(0xFF83bde5),
                                  keyType: TextInputType.emailAddress,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Nombre de tarea requerido'),
                                  ]),
                                ),
                                const SizedBox(height: 40.0),
                                InputForm(
                                  name: 'descripcion',
                                  hintText: 'Ingresa la descripcion de la tarea',
                                  icon: Icons.description_outlined  ,
                                  borderColor: const Color(0xFF83bde5),
                                  keyType: TextInputType.visiblePassword,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Descripcion requierida'),
                                  ]),
                                  obscureText: false,
                                ),

                                const SizedBox(height: 40.0),
                                SizedBox(
                                  height: 55,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _formKey.currentState?.save();
                                      if (_formKey.currentState?.validate() ==
                                          true) {
                                        //agregar las tareas a la base de datos
                                      }
                                    },
                                    child: const Text(
                                      'Iniciar sesión',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF83bde5),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                // Descomenta y ajusta si necesitas un enlace para registrarse
                                // const SizedBox(height: 40.0),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.pushNamed(context, RegisterScreen.routename);
                                //   },
                                //   child: const Text(
                                //     'Regístrate',
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 25.0,
                                //       decoration: TextDecoration.underline,
                                //       decorationColor: Colors.white
                                //     ),
                                //   ),
                                // ),
                              ]))))
            ],
          ),
        ),
      ),
    );
  }
}
