// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:ajalah/core/utils/flags_util.dart';
import 'package:ajalah/core/widgets/car_card_loading.dart';
import 'package:ajalah/features/home/logic/home_cubit.dart';
import 'package:ajalah/shared/models/car_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../app/theme/extensions/theme_extensions.dart';
import '../../core/utils/responsive_spacer.dart';
import '../../core/widgets/app_tag.dart';
import '../../core/widgets/car_img_slider.dart';

class CarCard extends StatefulWidget {
  final double width;
  final double height;
  final bool isImported;
  final CarCardItem? item;
  final List<String> imageUrls;

  const CarCard({
    super.key,
    required this.imageUrls,
    this.width = 300,
    this.height = 210,
    this.isImported = false,
    this.item,
  }) : assert(item != null, 'item must not be null');

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  bool isItemSaved = false;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    isItemSaved = widget.item?.isSaved ?? false;
    isSaving = false;
  }

  @override
  Widget build(BuildContext context) {
    final url = getFlagUrl(widget.item?.countryOfOrigin ?? "");
    final cubit = context.read<HomeCubit>();
    return Card(
      elevation: 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAliasWithSaveLayer,

      // clipBehavior: Clip.hardEdge,
      child: isSaving
          ? CarCardLoading(height: widget.height, width: widget.width)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: Stack(
                    children: [
                      CarImageSlider(
                        images: widget.imageUrls,
                        width: widget.width,
                        height: widget.height,
                      ),
                      Positioned(
                        top: 12,
                        left: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TagWidget(
                              tagName: widget.item?.tag.isNotEmpty == true
                                  ? widget.item!.tag[0].toString()
                                  : '',
                            ),
                            InkWell(
                              onTap: () async {
                                try {
                                  setState(() => isSaving = true);
                                  var data;
                                  if (isItemSaved) {
                                    data = await cubit.handleUnSave(
                                      widget.item?.savedVehicleId,
                                      widget.item?.ownerRole,
                                    );
                                  } else {
                                    data = await cubit.handleSave(
                                      widget.item?.id,
                                      widget.item!.ownerRole!,
                                    );
                                  }
                                  if (!mounted) return;
                                  setState(() {
                                    isItemSaved = data.isSaved ?? isItemSaved;
                                    isSaving = false;
                                  });
                                } catch (_) {
                                  setState(() => isSaving = false);
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    isItemSaved
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border,
                                    size: 22,
                                    color: context.colors.error.main,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: widget.width,
                  height: widget.height,

                  decoration: BoxDecoration(
                    color: context.colors.box,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.item?.name}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.2,
                          color: context.colors.text,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const ResponsiveSpacer(size: SpacerSize.xSmall),
                      Text(
                        widget.item?.description ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.2,
                          color: context.colors.grey[600]!,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const ResponsiveSpacer(size: SpacerSize.small),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TagWidget(
                            tagName: ((widget.item?.tag.length ?? 0) > 1
                                ? widget.item!.tag[1]
                                : ''),
                            tagColor: context.colors.primary.main,
                            textColor: Colors.white,
                            fontSize: 12.0,
                          ),
                          const SizedBox(width: 6),
                          TagWidget(
                            tagName: ((widget.item?.tag.length ?? 0) > 2
                                ? widget.item!.tag[2]
                                : ''),
                          ),
                        ],
                      ),

                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (widget.item?.ownerRole != 'imported') ...[
                                  SvgPicture.asset(
                                    'assets/icons/location.svg',
                                    height: 21,
                                    width: 20,
                                    colorFilter: ColorFilter.mode(
                                      context.colors.text,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.item?.location ?? '',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2,
                                      color: context.colors.text,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ] else if (url.startsWith("https")) ...[
                                  Image.network(url, width: 20, height: 20),
                                ] else ...[
                                  Icon(
                                    Icons.location_off,
                                    size: 22,
                                    color: context.colors.secondary.main,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Text(
                            '${widget.item?.price} \$',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                              color: context.colors.text,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
