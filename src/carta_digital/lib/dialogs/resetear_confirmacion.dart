import 'package:flutter/material.dart';

/// Muestra un diálogo de confirmación para resetear el pedido.
/// Retorna true si el usuario confirma, false o null si cancela.
Future<bool?> mostrarConfirmacionReset(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirmar acción'),
      content: const Text('¿Está seguro que desea resetear el pedido?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Sí, resetear'),
        ),
      ],
    ),
  );
}
