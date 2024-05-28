import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget menuTitleWidget(BuildContext context) {
  final locale = AppLocalizations.of(context)!;
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.diary,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          locale.unofficial_client,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    ),
    IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
  ]);
}
