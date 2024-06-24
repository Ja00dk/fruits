import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fruits/addCategoriaScreen.dart';
import 'package:fruits/modelCategoria.dart';
import 'package:fruits/produtoScreen.dart';
import 'package:fruits/sharedPreferencesHelper.dart';

class CategoriaScreen extends StatefulWidget {
  const CategoriaScreen({super.key});

  @override
  _CategoriaScreenState createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();
  List<Categoria> _categorias = [];

  @override
  void initState() {
    super.initState();
    _refreshCategorias();
  }

  Future<void> _refreshCategorias() async {
    final categorias = await _prefsHelper.getCategorias();
    setState(() {
      _categorias = categorias;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  void _addCategoria() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddCategoriaScreen(onSave: _refreshCategorias),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 227, 227, 227),
        title: const Text('Todas as Categorias'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: (_categorias.length / 2).ceil(),
        itemBuilder: (context, index) {
          final int firstIndex = index * 2;
          final int secondIndex = firstIndex + 1;
          return Row(
            children: <Widget>[
              const SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProdutoScreen(
                          categoriaNome: _categorias[firstIndex].nome,
                          categoriaId: _categorias[firstIndex].id,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _categorias[firstIndex].imagem.isNotEmpty
                                ? Image.file(File(_categorias[firstIndex].imagem))
                                : const SizedBox(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_categorias[firstIndex].nome),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              secondIndex < _categorias.length
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProdutoScreen(
                                categoriaNome: _categorias[secondIndex].nome,
                                categoriaId: _categorias[secondIndex].id,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _categorias[secondIndex].imagem.isNotEmpty
                                      ? Image.file(File(_categorias[secondIndex].imagem))
                                      : const SizedBox(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_categorias[secondIndex].nome),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Expanded(child: SizedBox()),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategoria,
        tooltip: 'Adicionar Categoria',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          enableFeedback: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Center(
                child: CircleAvatar(
                  backgroundColor: _selectedIndex == 0
                      ? const Color.fromARGB(255, 94, 196, 1)
                      : Colors.transparent,
                  child: Icon(
                    Icons.home,
                    color: _selectedIndex == 0
                        ? Colors.white
                        : const Color.fromARGB(255, 55, 71, 79),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Center(
                child: CircleAvatar(
                  backgroundColor: _selectedIndex == 1
                      ? const Color.fromARGB(255, 94, 196, 1)
                      : Colors.transparent,
                  child: Icon(
                    Icons.category,
                    color: _selectedIndex == 1
                        ? Colors.white
                        : const Color.fromARGB(255, 55, 71, 79),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Center(
                child: CircleAvatar(
                  backgroundColor: _selectedIndex == 2
                      ? const Color.fromARGB(255, 94, 196, 1)
                      : Colors.transparent,
                  child: Icon(
                    Icons.shopping_bag,
                    color: _selectedIndex == 2
                        ? Colors.white
                        : const Color.fromARGB(255, 55, 71, 79),
                  ),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Center(
                child: CircleAvatar(
                  backgroundColor: _selectedIndex == 3
                      ? const Color.fromARGB(255, 94, 196, 1)
                      : Colors.transparent,
                  child: Icon(
                    Icons.menu,
                    color: _selectedIndex == 3
                        ? Colors.white
                        : const Color.fromARGB(255, 55, 71, 79),
                  ),
                ),
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 48, 48, 48),
          unselectedItemColor: const Color.fromARGB(31, 0, 0, 0),
          onTap: _onItemTapped,
          selectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255),
            size: 30.0,
          ),
          selectedLabelStyle: const TextStyle(
            color: Colors.green,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
