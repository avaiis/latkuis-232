import 'package:flutter/material.dart';
import 'package:kuis1/models/animal_data.dart';
import 'package:kuis1/pages/detail_page.dart';
import 'package:kuis1/pages/login_page.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Menampilkan username yang dibawa dari LoginPage
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pet House",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            // Username dari form
            Text("Welcome, $username", style: const TextStyle(fontSize: 12)),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 209, 139, 220),

        // button logout
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),

      // Grid
      body: GridView.builder(
        padding: const EdgeInsets.all(15), // padding pinggir card
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom
          crossAxisSpacing: 10, // jarak kanan kiri antar card
          mainAxisSpacing: 10, // jarak atas bawah ca
          childAspectRatio: 0.8,
        ),

        // lopping konten hewan
        itemCount: dummyAnimals.length,
        itemBuilder: (context, index) {
          final animal = dummyAnimals[index];

          // ke halaman detail
          return AnimalCard(
            animal: animal,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(animal: animal),
              ),
            ),
          );
        },
      ),
    );
  }

  // Dialog Logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          "Logout",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ), // ke halaman login
              );
            },
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// isi card
class AnimalCard extends StatelessWidget {
  final dynamic animal;
  final VoidCallback onTap;

  const AnimalCard({super.key, required this.animal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),

                // gambar
                child: Image.network(
                  animal.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // nama hewan
                  Text(
                    animal.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),

                  // tipe
                  Text(
                    animal.type,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 5),

                  // habitat
                  Wrap(
                    spacing: 5,
                    children: animal.habitat
                        .map<Widget>((h) => _buildHabitatChip(h))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // isi habitat
  Widget _buildHabitatChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Text(
        label, // nama habitat
        style: TextStyle(
          fontSize: 10,
          color: Colors.purple.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
