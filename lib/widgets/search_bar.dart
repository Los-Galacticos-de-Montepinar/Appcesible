import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final String title;
  final Function(String) onTextChanged;

  const SearchBarWidget({
    super.key,
    required this.title,
    required this.onTextChanged
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchController,
          onChanged: (value) {
            widget.onTextChanged(value);
          },
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: 'Buscar ${widget.title}',
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            focusColor: Colors.black,
            floatingLabelStyle: const TextStyle(
              color: Colors.black
            ),
            prefixIcon: const Icon(Icons.search), // Agrega el icono de lupa
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
