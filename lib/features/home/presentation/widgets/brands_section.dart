import 'package:ajalah/features/home/presentation/widgets/brand_section_body.dart';
import 'package:ajalah/shared/models/brand_model.dart';
import 'package:flutter/material.dart';

class BrandsSection extends StatefulWidget {
  final List<BrandModel> brands;

  const BrandsSection({super.key, required this.brands});

  @override
  State<BrandsSection> createState() => _BrandsSectionState();
}

class _BrandsSectionState extends State<BrandsSection> {
  bool isShow = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firstFive = widget.brands.length > 5
        ? widget.brands.sublist(0, 5)
        : widget.brands;
    final remaining = widget.brands.length > 5 ? widget.brands.sublist(5) : [];
    return BrandSectionBody(
      firstFive: firstFive,
      remaining: remaining,
      isShow: isShow,
      onTap: () {
        setState(() {
          isShow = !isShow;
        });
      },
    );
  }
}
