import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InputForm extends StatelessWidget {
  final String name;
  final bool obscureText;
  final String hintText;
  final String? Function(String?)? validator;
  final IconData icon;
  final TextInputType keyType;
  final IconButton? suffixIcon;
  final Color borderColor;

  const InputForm({
    super.key,
    required this.name,
    required this.obscureText,
    required this.hintText,
    this.validator,
    required this.icon,
    required this.keyType,
    this.suffixIcon, 
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      name: name,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyType,
      decoration: InputDecoration(
        suffixIconColor: Color(0xFF283145),
        hintText: hintText,
        prefixIcon: Icon(icon),  // Mantengo el icono como prefijo
        suffixIcon: suffixIcon,   // Ahora se utiliza correctamente el IconButton pasado
        errorStyle:TextStyle(color: Colors.red,fontSize: 15,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide:BorderSide(
            color: borderColor,
          ),
        
        ),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.0),
        borderSide: BorderSide(
          color: borderColor,  // Color del borde cuando está enfocado
          width: 2.0,  // Opcional: puedes ajustar el grosor del borde cuando está enfocado
          ),
        )
      ),
    );
  }
}
