import 'package:flutter/material.dart';

import '../../../../core/shared/domain/entities/smart_room.dart';
import '../../../../core/theme/sh_colors.dart';

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 6,
      height: 6,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: SHColors.hintColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
