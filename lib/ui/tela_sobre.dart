import 'package:flutter/material.dart';

class TelaSobre extends StatelessWidget {
  const TelaSobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              Color.fromARGB(255, 225, 200, 200), // Substitua pela cor desejada
          title: const Text('Desenvolvedores'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaSobre(),
                  ),
                );
              },
              icon: const Icon(Icons.info),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: const Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Desenvolvido por',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors
                    .black, // Adiciona esta linha para definir a cor branca
              ),
            ),
            Text(
              'Tobias Santos',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors
                    .black, // Adiciona esta linha para definir a cor branca
              ),
            ),
            Text(
              '&',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors
                    .black, // Adiciona esta linha para definir a cor branca
              ),
            ),
            Text(
              'Davi Cruz',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors
                    .black, // Adiciona esta linha para definir a cor branca
              ),
            ),
          ]),
        ));
  }
}
