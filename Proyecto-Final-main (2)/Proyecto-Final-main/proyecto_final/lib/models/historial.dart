// historial.dart
class HistorialCompra {
  final String image;
  final String title;
  final double price;
  final int quantity;

  HistorialCompra({
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class Historial {
  static List<HistorialCompra> historial = [];
}
