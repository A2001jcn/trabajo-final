import 'package:flutter/material.dart';
import 'package:proyecto_final/fragments/favorite.dart';
import 'package:proyecto_final/fragments/productos_vista.dart';
import 'package:proyecto_final/fragments/profile.dart';
import 'package:proyecto_final/models/favmodel.dart';
import 'package:proyecto_final/models/user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool Busqueda = false;
  int _indiceNavigator = 0; // Índice seleccionado para el BottomNavigationBar
  final TextEditingController _busquedaControl = TextEditingController();

  // Lista de pantallas que se mostrarán según el índice
  late List<Widget> _screens;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    _screens = [
      ProductosVista(),
      const Center(
          child: Text('Pantalla de Carrito de compras',
              style: TextStyle(fontSize: 24))),
      const Center(
          child: Text('Pantalla de Historial de compras',
              style: TextStyle(fontSize: 24))),
      ProfilePage(user: user),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _indiceNavigator = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Busqueda
            ? TextField(
                controller: _busquedaControl,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Buscar...",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  print("Texto de búsqueda: $query");
                },
              )
            : const Text('Tienda de ropa A Z'),
        backgroundColor: const Color.fromARGB(247, 209, 40, 231),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                Busqueda = !Busqueda; // Alterna entre búsqueda y título normal
                if (!Busqueda) {
                  _busquedaControl
                      .clear(); // Limpiar el campo de búsqueda cuando se cierra
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FavoritosPage(favoritos: Favoritos.favoritos)));
            },
          ),
        ],
      ),
      body: _screens[
          _indiceNavigator], // Muestra la pantalla correspondiente según el índice seleccionado
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        currentIndex: _indiceNavigator, // El índice de la pestaña seleccionada
        onTap: _onItemTapped, // Cambia el índice cuando el usuario toca un ítem
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_sharp),
            label: 'Perfil',
          )
        ],
      ),
    );
  }
}
