import 'package:flutter/material.dart';

class ItemListWidget extends StatelessWidget {
  final List<String> elements;
  final Function(String) onItemTap;

  const ItemListWidget(
      {Key? key, required this.elements, required this.onItemTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
        controller: ScrollController(),
        shrinkWrap: true,
        itemCount: elements.length,
        itemBuilder: (context, index) {
          return _buildEstudianteTile(context, elements[index]);
        },
      ),
    );
  }

  Widget _buildEstudianteTile(BuildContext context, String estudiante) {
    return ListTile(
      leading: const SizedBox(
        width: 40,
        height: 40,
        child: Icon(Icons.account_circle, size: 40, color: Colors.black),
      ),
      title: Text(estudiante),
      onTap: () {
        onItemTap(estudiante);
      },
    );
  }
}
