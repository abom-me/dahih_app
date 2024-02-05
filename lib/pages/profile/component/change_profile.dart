import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/settings/sizes.dart';

import '../../../components/public_data.dart';
import '../../../viewmodel/profile_viewmodel.dart';

class SelectAvatar extends ConsumerWidget {
  const SelectAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      width: Sizes.width(context),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),

        itemCount: avatars.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              ref.read(profileViewModelProvider).changeProfileImage(avatars[index]);
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                border: const Border(
                  bottom: BorderSide.none,
                ),
              ),
              child: Image.asset(
                "assets/avatars/${avatars[index]}",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      )
    );
  }
}