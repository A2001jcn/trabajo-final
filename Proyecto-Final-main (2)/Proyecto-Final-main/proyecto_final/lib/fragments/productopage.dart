import 'package:flutter/material.dart';
import 'package:proyecto_final/models/modelo.dart'; // Asegúrate de tener el modelo Producto importado
import 'package:proyecto_final/Cart.dart'; // Importar el carrito
import 'package:proyecto_final/CarritoPage.dart'; // Importar la página Carrito

class ProductoPage extends StatefulWidget {
  final Producto producto;

  const ProductoPage({super.key, required this.producto});

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        // Lógica para agregar a favoritos
      } else {
        // Lógica para quitar de favoritos
      }
    });
  }

  void _addToCart() {
    int quantity = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar al Carrito'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Cantidad:'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Text('$quantity', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Crear un mapa con el producto y la cantidad seleccionada
                final productMap = {
                  'image': widget.producto.image,
                  'title': widget.producto.title,
                  'price': widget.producto.price,
                  'quantity': quantity,
                };

                // Agregar el producto al carrito
                Cart.addToCart(productMap);

                // Cerrar el diálogo
                Navigator.of(context).pop();

                // Mostrar mensaje
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Producto agregado al carrito')),
                );
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda de ropa A Z'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navegar a la página del carrito
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CarritoPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.producto.image,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.producto.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${widget.producto.price}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.producto.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: _addToCart,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
