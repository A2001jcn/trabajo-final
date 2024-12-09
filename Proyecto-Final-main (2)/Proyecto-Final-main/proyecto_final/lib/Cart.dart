class Cart {
  static List<Map<String, dynamic>> cartItems = [];

  // Agregar un producto al carrito
  static void addToCart(Map<String, dynamic> product) {
    // Verificar si el producto ya está en el carrito
    bool exists = false;
    for (var item in cartItems) {
      if (item['title'] == product['title']) {
        // Si el producto existe, aumentamos la cantidad
        item['quantity'] += product['quantity'];
        exists = true;
        break;
      }
    }
    // Si no existe, agregar el producto nuevo al carrito
    if (!exists) {
      cartItems.add(product);
    }
  }

  // Aumentar la cantidad de un producto en el carrito
  static void increaseQuantity(int index) {
    cartItems[index]['quantity']++;
  }

  // Reducir la cantidad de un producto en el carrito
  static void decreaseQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
    }
  }

  // Eliminar un producto del carrito
  static void removeProduct(int index) {
    cartItems.removeAt(index);
  }

  // Obtener los productos del carrito
  static List<Map<String, dynamic>> getCartItems() {
    return cartItems;
  }

  // Limpiar el carrito (si es necesario)
  static void clearCart() {
    cartItems.clear();
  }
}
