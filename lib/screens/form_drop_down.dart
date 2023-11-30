import 'package:flutter/material.dart';

class MaterialFormEntryWithDropdown extends StatefulWidget {
  final String name;
  final Function(String) onMaterialSelected;

  const MaterialFormEntryWithDropdown({
    super.key,
    required this.name,
    required this.onMaterialSelected,
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
            items: _buildDropdownItems(),
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

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    List<String> materialTypes = ["Material 1", "Material 2", "Material 3"];

    return materialTypes.map((type) {
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
