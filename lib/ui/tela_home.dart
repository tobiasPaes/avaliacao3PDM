import 'package:flutter/material.dart';
import 'package:terceira_prova/ui/tela_captura.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Meu App 3 unidade',
      home: HomeInfo(),
    );
  }
}

class HomeInfo extends StatefulWidget {
  const HomeInfo({super.key});

  @override
  State<HomeInfo> createState() => _HomeInfoState();
}

class _HomeInfoState extends State<HomeInfo> {
  int _selectedItem = 0;

  List<Widget> _widgetOptions = <Widget>[
    InfoApp(),
    TelaCaptura(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu App Av3'),
      ),
      body: _widgetOptions[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'info app',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Capturar Pokemons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Pokemons Capturados',
            activeIcon: null,
          )
        ],
        currentIndex: _selectedItem,
        onTap: _onItemTapped,
      ),
    );
  }
}

class InfoApp extends StatelessWidget {
  const InfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Este é um app sobre pokemons'),
          Text('Aqui você pode capturar pokemons'),
          Text('e ver todos seus pokemons capturados'),
        ],
      ),
    );
  }
}
