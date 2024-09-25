import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gestion_tareas/screens/home_screen.dart';
import 'package:gestion_tareas/utils/auth_service.dart';
import 'package:gestion_tareas/widgets/input_form_builder.dart';

class LoginScreen extends StatefulWidget {
  static const String routename = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF83bde5),
      body: Row(
        children: [
        
          Expanded(
            child: Container(
              height: double.infinity,
              child: Center(
                child: Text(
                  'Gestion de Tareas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                  ),),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              
              decoration: const BoxDecoration(
                color: Color(0xFF283145),
                
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 40.0),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bienvenido',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 60.0),
                      InputForm(
                        name: 'email',
                        obscureText: false,
                        hintText: 'Ingresa tu correo',
                        icon: Icons.mail,
                        borderColor: const Color(0xFF83bde5),
                        keyType: TextInputType.emailAddress,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'Email requerido'),
                          FormBuilderValidators.email(
                            regex: RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"),
                            errorText: 'Ingrese un email valido',
                          ),
                        ]),
                      ),
                      const SizedBox(height: 40.0),
                      InputForm(
                        name: 'password',
                        obscureText: _obscureText,
                        hintText: 'Ingresa tu contraseña',
                        icon: Icons.key,
                        borderColor: const Color(0xFF83bde5),
                        keyType: TextInputType.visiblePassword,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'Contraseña requerida'),
                          FormBuilderValidators.minLength(6, errorText: 'Minimo 6 caracteres'),
                        ]),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            _formKey.currentState?.save();
                            if (_formKey.currentState?.validate() == true) {
                              final values = _formKey.currentState?.value;
                              var result = await authService.login(values?['email'], values?['password']);
                              switch (result) {
                                case 0:
                                  // Inicio de sesión exitoso
                                  Navigator.popAndPushNamed(context, HomeScreen.routename);
                                  break;
                                case 1:
                                  // Usuario no encontrado
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Usuario no encontrado'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  break;
                                case 2:
                                  // Contraseña incorrecta
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Contraseña incorrecta'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  break;
                                default:
                                  // Otro error
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Error al iniciar sesión'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                              }
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
