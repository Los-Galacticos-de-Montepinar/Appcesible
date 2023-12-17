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
          decoration: InputDecoration(
            labelText: 'Buscar ${widget.title}',
            border: const OutlineInputBorder(),
            focusColor: Colors.black45,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black45,
                width: 2.0
              )
            ),
            floatingLabelStyle: const TextStyle(
              color: Colors.black45
            ),
            prefixIcon: const Icon(Icons.search), // Agrega el icono de lupa
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
