import 'package:flutter/material.dart';
import 'package:terceira_prova/ui/tela_captura.dart';
import 'package:terceira_prova/ui/tela_pokemon_capturado.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          title: Text(
            'Pokemons',
            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Info',
                // Adicione a cor desejada aqui
                icon: Icon(Icons.info_outline, color: Colors.green),
              ),
              Tab(
                text: 'Capturar',
                // Adicione a cor desejada aqui
                icon: Icon(Icons.add, color: Colors.orange),
              ),
              Tab(
                text: 'Capturados',
                // Adicione a cor desejada aqui
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
        color: Colors.white
            .withOpacity(0.7), // Ajuste a opacidade conforme necessário
        image: DecorationImage(
          image: AssetImage("assets/aaaa.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 300), // Ajuste a altura conforme necessário
            CustomText(
              text: 'Este é um app sobre pokemons',
              fontSize: 20, // Ajuste o tamanho da fonte conforme necessário
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
        color:
            const Color.fromARGB(255, 0, 0, 0), // Adicione a cor desejada aqui
      ),
    );
  }
}
