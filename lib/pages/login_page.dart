import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/blue_button.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Logo(titulo: 'Messenger'),
        
                _Form(),
        
                Labels(
                  ruta: 'register',
                  pregunta: '¿No tienes una cuenta?',
                  accion: '¡Crea una ahora!'
                ),
        
                Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200))
              ]
            ),
          ),
        )
      )
    );
  }
}


class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock,
            placeholder: 'Contraseña',
            textController: pwdCtrl,
            isPassword: true
          ),

          BlueButton(
            onPressed: authService.autenticando ? null : () async {
              FocusScope.of(context).unfocus();
              final login = await authService.login(emailCtrl.text.trim(), pwdCtrl.text.trim());
              if (login) {
                Navigator.pushReplacementNamed(context, 'users');
              } else {
                mostrarAlerta(context, 'Login incorrecto', 'Credenciales incorrectas');
              }
            },
            text: 'Ingresar'
          )
          
        ]
      )
    );
  }
}