import 'package:carta_digital/widgets/randomwidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carta_digital/providers/constante_autenticacion.dart'; // contiene AuthProvider

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
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
              setState(() {
                _isLoading = true;
              });

              final user = await authProvider.signInWithGoogle();

              setState(() {
                _isLoading = false;
              });

              if (user != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Bienvenido ${user.displayName ?? 'usuario'}')),
                );

                if (mounted) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error al iniciar sesión')),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}