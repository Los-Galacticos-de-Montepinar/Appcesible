import 'package:flutter/material.dart';

import 'package:appcesible/widgets/item_list.dart';
import 'package:appcesible/widgets/search_bar.dart';

class DialogWithSearchBar extends StatefulWidget {
  final String? title;
  final String label;
  final List<String> elements;
  final bool showCloseIcon;
  final bool showSearchBar;

  const DialogWithSearchBar({
    super.key,
    this.title,
    required this.label,
    required this.elements,
    this.showCloseIcon = true,
    this.showSearchBar = true,
  });

  @override
  State<DialogWithSearchBar> createState() => _DialogWithSearchBarState();
}

class _DialogWithSearchBarState extends State<DialogWithSearchBar> {
  List<String> filteredElements = [];

  @override
  void initState() {
    filteredElements = List.from(widget.elements);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title != null
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Buscar ${widget.label}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (widget.showCloseIcon)
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
              if (widget.showSearchBar)
                const SizedBox(height: 8.0),
              if (widget.showSearchBar)
                SearchBarWidget(
                  title: widget.label,
                  onTextChanged: (value) {
                    setState(() {
                      filteredElements = widget.elements
                        .where((estudiante) => estudiante
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                    });
                  },
                ),
            ],
          )
        : Column(
            children: [
              if (widget.showSearchBar)
                const SizedBox(height: 8.0),
              if (widget.showSearchBar)
                SearchBarWidget(
                  title: widget.label,
                  onTextChanged: (value) {
                    setState(() {
                      filteredElements = widget.elements
                        .where((estudiante) => estudiante
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                    });
                  },
                ),
            ],
          ),
      contentPadding: EdgeInsets.zero, // Ajuste el espacio interno
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: ItemListWidget(
        elements: filteredElements,
        onItemTap: (estudiante) {
          Navigator.pop(context, estudiante);
        },
      ),
    );
  }
}
