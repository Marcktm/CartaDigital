import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carta_digital/login/constante_autenticacion.dart'; // contiene AuthProvider

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.login),
          label: const Text('Iniciar sesión con Google'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 18),
          ),
          onPressed: () async {
            await authProvider.signInWithGoogle();
            const Text("Apretaste boton");
            
          },
        ),
      ),
    );
  }
}
