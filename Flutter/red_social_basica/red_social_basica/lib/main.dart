// // //Este es el ofcial el otro codigo comentado es de seguridad por si pasa algo

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/users_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // Este widget es la raíz de la aplicación.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
    _checkLoginStatus();
  }

  // Cargar la preferencia de tema almacenada
  void _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt('themeMode');
    setState(() {
      _themeMode = ThemeMode.values[themeIndex ?? 0];
    });
  }

  // Verificar si el usuario ya inició sesión
  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.containsKey('userId');
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  // Guardar la preferencia de tema
  void _saveThemePreference(ThemeMode mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Red Social Básica',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.light(
          secondary: const Color.fromARGB(255, 120, 1, 131),
        ),
        appBarTheme: AppBarTheme(
          color: const Color.fromARGB(229, 104, 17, 17),
          iconTheme:
              IconThemeData(color: const Color.fromARGB(255, 193, 202, 209)),
          titleTextStyle: TextStyle(
              color: const Color.fromARGB(227, 206, 215, 221), fontSize: 20),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.dark(
          secondary: const Color.fromARGB(255, 89, 2, 120),
        ),
      ),
      themeMode: _themeMode, // Modo de tema seleccionado
      home: _isLoggedIn
          ? HomeScreen(
              onThemeChanged: _toggleThemeMode,
            )
          : LoginScreen(
              onThemeChanged: _toggleThemeMode,
            ),
    );
  }

  void _toggleThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
    _saveThemePreference(mode);
  }
}

class HomeScreen extends StatelessWidget {
  final Function(ThemeMode) onThemeChanged;

  HomeScreen({required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Red Social Básica'),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              // Añadir una animación de transición al navegar entre pantallas
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      UsersScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.thumb_up_alt_outlined),
            onPressed: () {
              // Feedback táctil al usuario utilizando InkWell
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Funcionalidad de "👍" activada')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Feedback táctil al usuario utilizando InkWell
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Funcionalidad de "↪" activada')),
              );
            },
          ),
          PopupMenuButton<ThemeMode>(
            onSelected: onThemeChanged,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ThemeMode.system,
                child: Text('Predeterminado'),
              ),
              PopupMenuItem(
                value: ThemeMode.light,
                child: Text('Modo Claro'),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Text('Modo Oscuro'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Bienvenido a la Red Social Básica FAKEBOOK')),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Bienvenido a la Red Social Básica',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
