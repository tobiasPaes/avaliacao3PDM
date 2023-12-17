import 'package:flutter/material.dart';
import 'package:terceira_prova/ui/tela_captura.dart';
import 'package:terceira_prova/ui/tela_pokemon_capturado.dart';

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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meu App Av3'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'info page',),
              Tab(text: 'Capturar Pokemons',),
              Tab(text: 'Pokemons Capturados',),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InfoApp(),
            TelaCaptura(),
            TelaPokemonCapturado(),
          ],
        ),
      )
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
