import 'package:flutter/material.dart';

class LeagueSelectionScreen extends StatelessWidget {
  const LeagueSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final codeCtrl = TextEditingController();
    final nameCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Selecciona liga')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: codeCtrl,
              decoration: const InputDecoration(
                labelText: 'Código de invitación',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Unirse a liga'),
            ),
            const Divider(height: 32),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre de la liga',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Crear liga'),
            ),
          ],
        ),
      ),
    );
  }
}
