import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onTextChanged;

  const SearchBarWidget({Key? key, required this.onTextChanged})
      : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
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
            labelText: 'Buscar',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
