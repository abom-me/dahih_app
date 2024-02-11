import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

KeyboardActionsConfig buildConfig(BuildContext context,List<FocusNode> nodes) {
  return KeyboardActionsConfig(
    keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
    keyboardBarColor: Theme.of(context).colorScheme.background,
    nextFocus: false,
    actions: nodes
        .map((node) => KeyboardActionsItem(
        focusNode: node, toolbarButtons: [
          (nodee) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(FluentIcons.keyboard_dock_24_filled,color: Theme.of(context).colorScheme.secondary,size: 30,),
          ),
        );
      }
    ])
    )
        .toList(),
  );
}
