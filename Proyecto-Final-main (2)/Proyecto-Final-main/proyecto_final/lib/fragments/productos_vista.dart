import 'package:flutter/material.dart';
import 'package:proyecto_final/fragments/productopage.dart';
import 'package:proyecto_final/models/modelo.dart';
import 'package:proyecto_final/provider/productos.dart';

class ProductosVista extends StatelessWidget {
  ProductosVista({super.key});

  final productosProvider = ProductosProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
        future: productosProvider.getProductsAsync(),
        builder: (contex, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Error al obtener los productos'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('No hay productos'),
            );
          }

          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  final Producto producto = snapshot.data![index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => ProductoPage(producto: producto),
                          ),
                        );
                    },
                    child: Card(
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                           child: Image.network(
                            producto.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: 
                              Text(
                                producto.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                              ),),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(producto.category),)
                        ],
                      ),
                    )
                  );
                }
            );
        },
      ),
    );
  }
}