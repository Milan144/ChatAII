// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  final String? name;

  const CharacterTile({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.circle),
      title: Text(name!),
      onTap: () {
        print("Tapped $name");
      },
    );
  }
}
