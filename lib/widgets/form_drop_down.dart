import 'package:flutter/material.dart';

class MaterialFormEntryWithDropdown extends StatefulWidget {
  final String name;
  final Function(String) onMaterialSelected;
  final List<String> elements;

  const MaterialFormEntryWithDropdown({
    super.key,
    required this.name,
    required this.onMaterialSelected,
    required this.elements
  });

  @override
  State<MaterialFormEntryWithDropdown> createState() => _MaterialFormEntryWithDropdownState();
}

class _MaterialFormEntryWithDropdownState extends State<MaterialFormEntryWithDropdown> {
  String? selectedMaterial;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: widget.name,
              border: const OutlineInputBorder(),
            ),
            value: selectedMaterial,
            items: _buildDropdownItems(widget.elements),
            onChanged: (value) {
              setState(() {
                if (selectedMaterial != value) {
                  selectedMaterial = value;
                  widget.onMaterialSelected(value!);
                }
              });
            },
            isExpanded: true,
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(List<String> elements) {
    return elements.map((type) {
      return DropdownMenuItem<String>(
        value: type,
        child: SizedBox(
          width: 200,
          child: Text(type),
        ),
      );
    }).toList();
  }
}
