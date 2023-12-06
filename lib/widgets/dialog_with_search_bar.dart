import 'package:flutter/material.dart';

class DialogWithSearchBar extends StatefulWidget {
  final List<String> elements;
  
  const DialogWithSearchBar({super.key, required this.elements});

  @override
  State<DialogWithSearchBar> createState() => _DialogWithSearchBarState();
}

class _DialogWithSearchBarState extends State<DialogWithSearchBar> {
  List<String> filteredElements = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredElements = List.from(widget.elements);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Buscar Estudiante',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8.0
          ),
          TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                filteredElements = widget.elements
                    .where((estudiante) => estudiante
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
            },
            decoration: const InputDecoration(
              labelText: 'Buscar Estudiante',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search), // Agrega el icono de lupa
            ),
          ),
          const SizedBox(
            height: 8.0
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero, // Ajuste el espacio interno
      backgroundColor: Colors.white,
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          controller: ScrollController(),
          shrinkWrap: true,
          itemCount: filteredElements.length,
          itemBuilder: (context, index) {
            return _buildEstudianteTile(filteredElements[index]);
          },
        ),
      ),
    );
  }

  Widget _buildEstudianteTile(String estudiante) {
    return ListTile(
      leading: const SizedBox(
        width: 40,
        height: 40,
        child: Icon(Icons.account_circle, size: 40, color: Colors.black),
      ),
      title: Text(estudiante),
      onTap: () {
        Navigator.pop(context, estudiante);
      },
    );
  }
}
