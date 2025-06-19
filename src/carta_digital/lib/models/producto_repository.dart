import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'producto.dart';
import '../services/servicio_google_sheets.dart';

class ProductoRepository {

  final UserSheetApi _datosCarta = UserSheetApi.getinstance();

  Future<List<Producto>> cargarDesdeGoogleSheets() async {
    final hoja = _datosCarta.getSpreedsheet();
    if (hoja == null) throw Exception("No se pudo obtener la hoja 'Carta'");

    final rows = await hoja.values.allRows();
    final data = rows.skip(1); // omitir cabecera

    return data
        .map((row) => Producto(
              nombre: row[0] ?? '',
              precio: (int.tryParse(row[1] ?? '0') ?? 0).toDouble(),
              categoria: row[2] ?? '',
              stock: (row[3] ?? '').toLowerCase() == 'si',
            ))
        .where((p) => p.stock)
        .toList();
  }


  Future<List<Producto>> cargarPorCategoria(String categoria) async {
    final productos = await cargarDesdeGoogleSheets();
    return productos.where((p) => p.categoria == categoria).toList();
  }

}
