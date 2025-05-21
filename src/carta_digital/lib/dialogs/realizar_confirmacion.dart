import 'package:flutter/material.dart';

/// Muestra un diálogo de confirmación para realizar el pedido.
/// Retorna true si el usuario confirma, false o null si cancela.
Future<bool?> mostrarConfirmacionRealizar(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirmar pedido'),
      content: const Text('¿Está seguro que desea realizar el pedido?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Sí, enviar'),
        ),
      ],
    ),
  );
}
