import 'package:flutter/material.dart';

class FormEntryWithDropdown extends StatefulWidget {
  final String name;
  final Function(String) onElementSelected;
  final List<String> elements;

  const FormEntryWithDropdown({
    super.key,
    required this.name,
    required this.onElementSelected,
    required this.elements
  });

  @override
  State<FormEntryWithDropdown> createState() => _FormEntryWithDropdownState();
}

class _FormEntryWithDropdownState extends State<FormEntryWithDropdown> {
  String? selectedElement;

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