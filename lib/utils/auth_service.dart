import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:gestion_tareas/screens/login.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<int> login(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    final a = userCredential.user;
    if (a?.uid != null) {
      return 0; // Inicio de sesión exitoso
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 1; // Usuario no encontrado
    } else if (e.code == 'wrong-password') {
      return 2; // Contraseña incorrecta
    }
  }

  return 3; // Otro error
}

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      print("Sesión cerrada correctamente");

      // Redirigir al usuario a la pantalla de login eliminando las rutas anteriores
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routename,  // El nombre de la ruta de tu pantalla de login
        (Route<dynamic> route) => false,  // Elimina todas las rutas anteriores
      );
    } catch (e) {
      print("Error al cerrar sesión: $e");
    }
  }
}