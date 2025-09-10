import 'package:shadcn_flutter/shadcn_flutter.dart';

// TODO: Refactor to a factory class later
IconData getTreeIcon(String name) {
  name = name.toLowerCase();
  if (name.contains('text')) {
    return RadixIcons.text;
  } else if (name.contains('image')) {
    return RadixIcons.image;
  } else if (name.contains('column')) {
    return BootstrapIcons.viewStacked;
  } else if (name.contains('view')) {
    return BootstrapIcons.tv;
  }

  return RadixIcons.group;
}
