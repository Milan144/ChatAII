// ignore_for_file: file_names

import 'package:chatai/pages/characters_page.dart';
import 'package:chatai/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UniverseTile extends StatelessWidget {
  final String? name;
  final int? id;

  const UniverseTile({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.circle),
      title: Text(name!),
      onTap: () {
        nextScreen(context, CharactersPage(idUniverse: id!));
      },
    );
  }
}
