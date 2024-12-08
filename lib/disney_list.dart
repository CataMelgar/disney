import 'package:disney/disney_card.dart';
import 'package:flutter/material.dart';
import 'disney_model.dart';

class DisneyList extends StatelessWidget {
  final List<Disney> disneys;
  const DisneyList(this.disneys, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: disneys.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return DisneyCard(disneys[int]);
      },
    );
  }
}
