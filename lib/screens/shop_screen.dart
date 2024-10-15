import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Tres categorías
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda de Artículos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Comida'),
            Tab(text: 'Juguetes'),
            Tab(text: 'Accesorios'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner de la tienda
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                '¡Bienvenido a la Tienda!',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCategory('Comida'),
                _buildCategory('Juguetes'),
                _buildCategory('Accesorios'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(String category) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: 6, // Ejemplo: 6 artículos por categoría
        itemBuilder: (context, index) {
          return _buildShopItem(index, category);
        },
      ),
    );
  }

  Widget _buildShopItem(int index, String category) {
    return GestureDetector(
      onTap: () {
        _showPurchaseDialog(category, index);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blueAccent.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Artículo $index',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              '\$15.99',
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                _showPurchaseDialog(category, index);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textStyle: const TextStyle(fontSize: 14),
              ),
              child: const Text('Comprar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPurchaseDialog(String category, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Comprar Artículo $index'),
          content:
              Text('¿Deseas comprar este artículo de la categoría $category?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Comprar'),
              onPressed: () {
                Navigator.of(context).pop();
                // Aquí puedes añadir la lógica para procesar la compra
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Has comprado Artículo $index en $category'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
