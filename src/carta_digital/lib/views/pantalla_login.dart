import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carta_digital/providers/constante_autenticacion.dart'; // contiene AuthProvider

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
            final user = await authProvider.signInWithGoogle();
            if (user != null) {
               ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Bienvenido ${user.displayName ?? 'usuario'}')),
             );
    // Aquí podrías navegar a otra pantalla si lo necesitás:
    // Navigator.pushReplacementNamed(context, '/home');
          } else {
             ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al iniciar sesión')),
             );
         }
      },
        ),
      ),
    );
  }
}
