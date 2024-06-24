import 'package:flutter/material.dart';
import 'package:fruits/SlapshScreen.dart';
import 'package:fruits/addCategoriaScreen.dart';
import 'package:fruits/categoriaScreen.dart';
import 'package:fruits/modelCategoria.dart';
import 'package:fruits/sacolaScreen.dart';
import 'package:fruits/opcoesScreen.dart';
import 'package:fruits/sharedPreferencesHelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SlapshScreen extends StatefulWidget {
  const SlapshScreen({super.key});

  @override
  SpalshScreenState createState() => SpalshScreenState();
}

class SpalshScreenState extends State<SlapshScreen> {
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();
  List<Categoria> _categorias = [];
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[];  
    _refreshCategorias();
  }

  Future<void> _refreshCategorias() async {
    final categorias = await _prefsHelper.getCategorias();
    setState(() {
      _categorias = categorias;
      _widgetOptions = <Widget>[
        CategoriaScreen(),
        AddCategoriaScreen(onSave: _refreshCategorias),
        SacolaScreen(),
        CameraGalleryApp(),
      ];
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: _widgetOptions.isNotEmpty
          ? _widgetOptions.elementAt(_selectedIndex)
          : Center(child: CircularProgressIndicator()),  
      
    );
  }
}



