import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carta_digital/providers/constante_autenticacion.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLoading)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}


class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ElevatedButton.icon(
      icon: const Icon(Icons.logout),
      label: const Text('Cerrar sesión'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
        backgroundColor: const Color.fromARGB(255, 3, 64, 88),
        foregroundColor: Colors.white, // ← texto e ícono en blanco
      ),
      onPressed: () async {
        await authProvider.signOut();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sesión cerrada')),
        );
      },
    );
  }
}


