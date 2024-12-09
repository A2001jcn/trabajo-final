import 'package:flutter/material.dart';
import 'package:proyecto_final/Cart.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});

  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  void _removeProduct(int index) {
    setState(() {
      Cart.removeProduct(index);
    });
  }

  void _increaseQuantity(int index) {
    setState(() {
      Cart.cartItems[index]['quantity']++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (Cart.cartItems[index]['quantity'] > 1) {
        Cart.cartItems[index]['quantity']--;
      }
    });
  }

  void _updateQuantity(int index, String value) {
    setState(() {
      int quantity = int.tryParse(value) ?? 1;
      Cart.cartItems[index]['quantity'] = quantity;
    });
  }

  double _calculateTotal() {
    double total = 0.0;
    for (var product in Cart.cartItems) {
      total += product['price'] * product['quantity'];
    }
    return total;
  }

  void _clearCart() {
    setState(() {
      Cart.cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Cart.cartItems.isEmpty
            ? const Center(child: Text('El carrito está vacío'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: Cart.cartItems.length,
                      itemBuilder: (context, index) {
                        final product = Cart.cartItems[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: Image.network(product['image']),
                            title: Text(product['title']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '\$${product['price']} x ${product['quantity']}'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () => _decreaseQuantity(index),
                                    ),
                                    Container(
                                      width: 50,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        textAlign: TextAlign.center,
                                        controller: TextEditingController(
                                          text: '${product['quantity']}',
                                        ),
                                        onChanged: (value) {
                                          _updateQuantity(index, value);
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () => _increaseQuantity(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _removeProduct(index); // Eliminar el producto
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Mostrar el total al final
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: \$${_calculateTotal().toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Mostrar mensaje de "pagado" y limpiar el carrito
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Pago Realizado'),
                                  content:
                                      const Text('¡Gracias por tu compra!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _clearCart(); // Limpiar el carrito
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cerrar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Pagar'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
