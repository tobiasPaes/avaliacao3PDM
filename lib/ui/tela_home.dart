import 'package:flutter/material.dart';
import 'package:terceira_prova/ui/tela_captura.dart';
import 'package:terceira_prova/ui/tela_pokemon_capturado.dart';
import 'package:terceira_prova/ui/tela_sobre.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key});

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
  const HomeInfo({Key? key});

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
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text(
            'Pokemons',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline,
                  color: Colors.white), // Defina a cor para branca aqui
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaSobre()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Info',
                icon: Icon(Icons.info_outline, color: Colors.green),
              ),
              Tab(
                text: 'Capturar',
                icon: Icon(Icons.add, color: Colors.orange),
              ),
              Tab(
                text: 'Capturados',
                icon: Icon(Icons.list, color: Colors.red),
              ),
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
      ),
    );
  }
}

class InfoApp extends StatelessWidget {
  const InfoApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        image: const DecorationImage(
          image: AssetImage("assets/aaaa.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 300),
            CustomText(
              text: 'Este é um app sobre pokemons',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: 'Aqui você pode capturar pokemons',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: 'e ver todos seus pokemons capturados',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomText({
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
