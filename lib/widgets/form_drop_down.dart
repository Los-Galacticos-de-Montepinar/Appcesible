import 'package:flutter/material.dart';

import 'package:appcesible/models/task_model.dart';

class MaterialFormEntryWithDropdown extends StatefulWidget {
  final String name;
  final Function(TaskItem) onMaterialSelected;
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
  TaskItem? selectedMaterial;

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
            value: selectedMaterial?.name,
            items: _buildDropdownItems(widget.elements),
            onChanged: (value) {
              setState(() {
                if (selectedMaterial?.name != value) {
                  selectedMaterial?.name = value!;
                  widget.onMaterialSelected(selectedMaterial!);
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
