import 'package:appcesible/screens/assign_fixed_task.dart';
import 'package:appcesible/screens/create_material_task.dart';
import 'package:flutter/material.dart';

class SelectTaskTypeDialog extends StatelessWidget {
  const SelectTaskTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      contentPadding: const EdgeInsets.all(8.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _OptionButton(
            text: 'Tarea Fija',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const TaskAsign();
              }));
            }
          ),
          const SizedBox(height: 8.0,),
          _OptionButton(
            text: 'Tarea Material',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const MaterialTask();
              }));
            }
          )
        ],
      )
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const _OptionButton({
    required this.text,
    required this.onPressed
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEEEEEE),
        surfaceTintColor: const Color(0xFFEEEEEE),
        foregroundColor: const Color(0xFFA7A7A7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(
            width: 1.5,
            color: Colors.black,
          ),
        ),
        minimumSize: const Size.fromHeight(80.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0
        ),
      ),
    );
  }

}