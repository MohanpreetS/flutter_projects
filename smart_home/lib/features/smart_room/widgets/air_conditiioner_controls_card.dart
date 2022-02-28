import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/core.dart';

class _AirIcons extends StatelessWidget {
  const _AirIcons();

  @override
  Widget build(BuildContext context) {
    return const IconTheme(
      data: IconThemeData(size: 30, color: Colors.white38),
      child: Row(
        children: [
          Icon(SHIcons.snowFlake),
          SizedBox(
            width: 8,
          ),
          Icon(SHIcons.wind),
          SizedBox(
            width: 8,
          ),
          Icon(SHIcons.waterDrop),
          SizedBox(
            width: 8,
          ),
          Icon(SHIcons.timer, color: SHColors.selectedColor),
        ],
      ),
    );
  }
}

class _AirSwitcher extends StatelessWidget {
  const _AirSwitcher({
    required this.room,
  });

  final SmartRoom room;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Air conditioning'),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SHSwitcher(
                icon: const Icon(SHIcons.fan),
                value: room.airCondition.isOn,
                onChanged: (value) {},
              ),
            ),
            const Spacer(),
            Text(
              '${room.airCondition.value}˚',
              style: const TextStyle(fontSize: 28),
            )
          ],
        )
      ],
    );
  }
}
