import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(VCardApp());

class VCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V-Card',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: VCardScreen(),
    );
  }
}

class VCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Tarjeta Digital'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 112, 111, 111),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE1BEE7),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // Desplazamiento de la sombra
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage('assets/profile.webp'), // Imagen del perfil
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Jankarlos Crespo Hernández',
                    style: GoogleFonts.lato(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'jcrespo7294@arecibointer.edu',
                    style: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '+1 (123) 456-7890',
                    style: GoogleFonts.openSans(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'https://github.com/Crespo3023',
                    style: GoogleFonts.openSans(
                        fontSize: 16, color: const Color(0xFF263238)),
                  ),
                  SizedBox(height: 20),
// Código QR (puede ser una imagen estática o generada por un paquete QR)
                  Image.asset(
                    'assets/qr-code.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 20),
// Botón de Expansión (solo como ejemplo visual)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Usuario de Github: Crespo3023',
                          style: GoogleFonts.openSans(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
