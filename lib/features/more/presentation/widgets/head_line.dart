import 'package:flutter/material.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/features/auth/models/user_model.dart';

class HeadLine extends StatefulWidget {
  final UserModel? user;
  const HeadLine({super.key, required this.user});

  @override
  State<HeadLine> createState() => _HeadLineState();
}

class _HeadLineState extends State<HeadLine> {
  @override
  Widget build(BuildContext context) {
    final textStyle = context.textStyles.styles;
    if (widget.user?.role == 'Seller') {
      return Text(
        '${widget.user?.fName} ${widget.user?.lName}',
        style: textStyle.headlineSmall,
      );
    } else {
      return Text(
        '${widget.user?.dealership?.tradingName}',
        style: textStyle.headlineSmall,
      );
    }
  }
}
