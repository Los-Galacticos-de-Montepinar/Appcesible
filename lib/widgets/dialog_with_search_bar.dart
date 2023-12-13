import 'package:flutter/material.dart';

class DialogWithSearchBar extends StatefulWidget {
  final String title;
  final List<String> elements;

  const DialogWithSearchBar(
      {super.key, required this.title, required this.elements});

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
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Buscar ${widget.title}',
                    style: const TextStyle(
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
          const SizedBox(height: 8.0),
          TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                filteredElements = widget.elements
                    .where((estudiante) =>
                        estudiante.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            },
            decoration: InputDecoration(
              labelText: 'Buscar ${widget.title}',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.search), // Agrega el icono de lupa
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
      contentPadding: EdgeInsets.zero, // Ajuste el espacio interno
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
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
