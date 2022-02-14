import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_common/ui_common.dart';

import '../../../../core/core.dart';

class _RoomInfoRow extends StatelessWidget {
  const _RoomInfoRow({
    required this.icon,
    required this.label,
    required this.data,
  });

  final Icon icon;
  final Text label;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        width32,
        IconTheme(
          data: context.iconTheme.copyWith(size: 18.sp),
          child: icon,
        ),
        width4,
        Expanded(
          child: DefaultTextStyle(
            style: context.bodySmall.copyWith(
              color: data == null ? context.textColor.withOpacity(.6) : null,
            ),
            child: label,
          ),
        ),
        if (data != null)
          Text(
            data!,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          )
        else
          Row(
            children: [
              const BlueLightDot(),
              width4,
              Text(
                'OFF',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w800,
                  fontSize: 12.sp,
                  color: SHColors.textColor.withOpacity(.6),
                ),
              ),
            ],
          ),
        width32,
      ],
    );
  }
}
