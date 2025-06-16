abstract class PrecioStrategy {
  double calcularPrecio(int cantidad, double precioBase);
}

class PrecioIndividual implements PrecioStrategy {
  @override
  double calcularPrecio(int cantidad, double precioBase) => cantidad * precioBase;
}

class PrecioPorMediaDocena implements PrecioStrategy {
  @override
  double calcularPrecio(int cantidad, double precioBase) {
    int bloques = cantidad ~/ 6; // cuántos bloques de 6 hay
    int resto = cantidad % 6;    // cuántas unidades quedan
    return (bloques * 6 * precioBase * 0.9) + (resto * precioBase);
  }
}

class PrecioPorDocena implements PrecioStrategy {
  @override
  double calcularPrecio(int cantidad, double precioBase) {
    int docenas = cantidad ~/ 12;
    int resto = cantidad % 12;

    // Para el resto, usá la estrategia de media docena si aplica
    double subtotalResto;
    if (resto >= 6) {
      subtotalResto = PrecioPorMediaDocena().calcularPrecio(resto, precioBase);
    } else {
      subtotalResto = resto * precioBase;
    }

    return (docenas * 12 * precioBase * 0.8) + subtotalResto;
  }
}
