import 'package:flutter/material.dart';
import 'package:proyecto_final/models/favmodel.dart';
import 'package:proyecto_final/models/modelo.dart';

class FavoritosPage extends StatefulWidget {
  final List<Producto> favoritos;

  const FavoritosPage({super.key, required this.favoritos});

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  void _removeFromFavorites(Producto producto) {
    setState(() {
      Favoritos.favoritos.remove(producto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: Colors.purple,
      ),
      body: widget.favoritos.isEmpty
          ? const Center(child: Text('No hay productos favoritos'))
          : ListView.builder(
              itemCount: widget.favoritos.length,
              itemBuilder: (context, index) {
                final producto = widget.favoritos[index];
                return ListTile(
                  leading: Image.network(producto.image),
                  title: Text(producto.title),
                  subtitle: Text('\$${producto.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      _removeFromFavorites(producto);
                    },
                  ),
                );
              },
            ),
    );
  }
}
