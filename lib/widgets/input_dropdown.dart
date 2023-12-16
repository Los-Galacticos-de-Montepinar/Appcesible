import 'package:flutter/material.dart';

class InputDropdown extends StatefulWidget {
  final String name;
  final Function(String) onElementSelected;
  final List<String> elements;
  final String? defaultValue;

  const InputDropdown({
    super.key,
    required this.name,
    required this.onElementSelected,
    required this.elements,
    this.defaultValue
  });

  @override
  State<InputDropdown> createState() => _InputDropdownState();
}

class _InputDropdownState extends State<InputDropdown> {
  String? selectedElement;

  @override
  void initState() {
    selectedElement = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: widget.name,
            border: const OutlineInputBorder(),
          ),
          value: selectedElement,
          dropdownColor: Colors.white,
          items: _buildDropdownItems(widget.elements),
          onChanged: (value) {
            setState(() {
              if (selectedElement != value) {
                selectedElement = value!;
                widget.onElementSelected(selectedElement!);
              }
            });
          },
          isExpanded: true,
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(List<String> elements) {
    return elements.map((element) {
      return DropdownMenuItem<String>(
        value: element,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(element),
        ),
      );
    }).toList();
  }
}
