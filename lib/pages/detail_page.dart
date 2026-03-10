// lib/pages/detail_page.dart
import 'package:flutter/material.dart';
import 'package:kuis1/models/animal_model.dart';

class DetailPage extends StatelessWidget {
  final Animal animal;

  const DetailPage({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          animal.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 209, 139, 220),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Hewan
          Image.network(
            animal.image,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Animal Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Info Dasar
                _buildInfoText("Height: ${animal.height}"),
                _buildInfoText("Weight: ${animal.weight}"),

                const SizedBox(height: 18),

                const Text(
                  "Animal Activities",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // activity
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: animal.activities
                      .map((activity) => _buildActivityChip(activity))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // pengaturan teks weight dan height
  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text, style: const TextStyle(fontSize: 15)),
    );
  }

  // dekorasi activity
  Widget _buildActivityChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.purple.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
